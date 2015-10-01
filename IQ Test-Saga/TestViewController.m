//
//  TestViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 28/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "TestViewController.h"
#import "TestCardView.h"
#import <QuartzCore/QuartzCore.h>
#import "LocalStore.h"
#import "SCLAlertView.h"
#import "SuccessViewController.h"
#import "ModalReviewPanel.h"
#import "UIImage+Resize.h"

#define kDeviceScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kDeviceScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface TestViewController ()<MZTimerLabelDelegate,ReviewDelegate,UAModalPanelDelegate>
{
    CAShapeLayer *rectProgress;
    CAKeyframeAnimation *rectColorAnimation;
    CABasicAnimation *timerAnimation;
    UIActivityIndicatorView *actView;
    NSMutableArray *questions;
    NSMutableArray *questionsMarked;
    NSMutableIndexSet *questionsReviewed;
    NSMutableArray *questionsUnmarked;
    int _score;
    SCLAlertView *_waitingAlert;
    SCLAlertView *_warningAlert;
    SCLAlertView *_correctAnswerAlert;
    ModalReviewPanel *_reviewPanel;

}

@property (strong, nonatomic) MZTimerLabel *counDowntimer;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UIButton *leftArrow;
@property (weak, nonatomic) IBOutlet UIButton *rightArrow;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *qNumberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitBtnWidthConstraint;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"iqBg.png"]]];
    
    questions = [[NSMutableArray alloc] initWithObjects:@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0), nil];
    questionsMarked = [NSMutableArray new];
    questionsReviewed = [NSMutableIndexSet new];
    questionsUnmarked = [NSMutableArray new];

    self.iCarousel.hidden = NO;
    self.iCarousel.type = iCarouselTypeLinear;

    self.counDowntimer = [[MZTimerLabel alloc] initWithLabel:self.counterLabel andTimerType:MZTimerLabelTypeTimer];
    [self.counDowntimer setCountDownTime:15*60];
    self.counDowntimer.delegate = self;
    self.counDowntimer.timeLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:25];
    self.counDowntimer.timeLabel.textColor = [UIColor whiteColor];
    self.counterLabel.layer.borderWidth = 1.0f;
    self.counterLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.counterLabel.layer.cornerRadius = 10.0f;
    self.counterLabel.layer.masksToBounds = YES;
    self.counDowntimer.timeFormat = @"mm:ss";
//    self.counterLabel.countDirection = kCountDirectionDown;
//    [self.counterLabel setStartValue:(15*60*1000)];
//    self.counterLabel.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    self.counterLabel.layer.borderWidth = 0;
//    self.counterLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    self.counterLabel.textColor = [UIColor blackColor];
//    self.counterLabel.layer.cornerRadius = 10.0f;
//    self.counterLabel.layer.masksToBounds = YES;
//    self.counterLabel.countdownDelegate = self;
    self.iCarousel.decelerationRate = 0.25f;
    
    //customizations for rapidfire round
    if (self.isRapidFire) {
        self.iCarousel.scrollEnabled = NO;
        self.iCarousel.centerItemWhenSelected = NO;
        [self.counDowntimer setCountDownTime:(60)];
        self.counDowntimer.timeFormat = @"ss";
        self.leftArrow.hidden = YES;
        self.leftArrow.enabled = NO;
        self.rightArrow.hidden = YES;
        self.rightArrow.enabled = NO;
        [self.submitButton setTitle:@"Submit Answer" forState:UIControlStateNormal];
        [self.submitButton setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.2f]];
        [[LocalStore sharedInstance] recreateRandomOrderWithForce:YES];
    }
    
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.numberOfLines = 10;
    [self.questionLabel setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:17]];
    [self.questionLabel setTextColor:[UIColor
                                      whiteColor]];
    self.questionLabel.adjustsFontSizeToFitWidth = YES;
    self.questionLabel.minimumScaleFactor = 0.25f;

    [[LocalStore sharedInstance] recreateRandomOrderWithForce:NO];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.counDowntimer start];
    [self initProgressRectWithDuration:([self.counDowntimer getCountDownTime])];
    
}

- (void)viewWillLayoutSubviews
{
    if (self.isRapidFire) {
        self.submitBtnWidthConstraint.constant = self.view.frame.size.width;
        [self.reviewButton removeFromSuperview];
    }

    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [rectProgress removeAllAnimations];
    [rectProgress removeFromSuperlayer];

}

- (void)initProgressRectWithDuration:(CGFloat)durationsInSeconds
{
    [rectProgress removeAllAnimations];
    [rectProgress removeFromSuperlayer];
    
    rectProgress = [CAShapeLayer layer];
    [rectProgress setStrokeColor:[UIColor greenColor].CGColor];
    [rectProgress setLineWidth:4.0f];
    [rectProgress setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kDeviceScreenWidth/2-77,10,154, 42) cornerRadius:5.0f];
    rectProgress.path = path.CGPath;
    
    rectColorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    rectColorAnimation.values = @[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
    rectColorAnimation.keyTimes = @[ @0, @(.75), @(1)];
    rectColorAnimation.duration = durationsInSeconds;
    rectColorAnimation.fillMode = kCAFillModeForwards;
    rectColorAnimation.removedOnCompletion = NO;

    timerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    timerAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    timerAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    timerAnimation.duration = durationsInSeconds;
    timerAnimation.fillMode = kCAFillModeForwards;
    timerAnimation.removedOnCompletion = NO;

    [rectProgress addAnimation:rectColorAnimation forKey:@"strokeColor"];
    [rectProgress addAnimation:timerAnimation forKey:@"strokeEnd"];
    //[self.view.layer addSublayer:rectProgress];
    
}

- (void)stopRectProgress {
    

}


- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if (self.isRapidFire) {
        return (NSInteger)150;
    }
    else {
        return (NSInteger)15;
    }
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    //create new view if no view is available for recycling
    if (view == nil)
    {
        //create a view from xib
        if (![[LocalStore sharedInstance]._order count]) {
            [[LocalStore sharedInstance] recreateRandomOrderWithForce:YES];
        }
        
        // remove from db so that this never shows up again
        int randomIndex = ((NSNumber*)[[LocalStore sharedInstance]._order objectAtIndex:0]).intValue;

        TestCardView *card = [[TestCardView alloc] initWithQuestionArray:(NSArray*)[[LocalStore sharedInstance]._testQuestions objectAtIndex:randomIndex]];
        card.isRapidFire = _isRapidFire;
        card.objectIndex = index + 1;
        card.indexInQArray = randomIndex;
        [card setupCard];
        if (!_isRapidFire) {
            [questions replaceObjectAtIndex:index withObject:card];
            [card setUserInteractionEnabled:NO];
        }
        

        NSString *query = [NSString stringWithFormat:@"delete from 'RandomOrder'  where RowID=%d",randomIndex];
        [[LocalStore sharedInstance].dbManager executeQuery:query];
        [[LocalStore sharedInstance]._order removeObjectAtIndex:0];

        return card;

    }
    
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return (value);
    }
    
    if (option == iCarouselOptionShowBackfaces) {
        return NO;
    }
    return value;
}

- (IBAction)leftRightArrowTapped:(id)sender
{
#warning check this if can create a circular carousel
    UIButton *btnTapped = (UIButton*)sender;
    
    if (btnTapped.tag == 0) //left button tapped
    {
        if (self.iCarousel.currentItemIndex - 1 >= 0) {
            [self.iCarousel scrollToItemAtIndex:self.iCarousel.currentItemIndex-1 animated:YES];
        }
        else {
            [self.iCarousel scrollToItemAtIndex:self.iCarousel.numberOfItems-1 animated:YES];
        }
    }
    else
    {
        if (self.iCarousel.currentItemIndex + 1 <= self.iCarousel.numberOfItems - 1) {
            [self.iCarousel scrollToItemAtIndex:self.iCarousel.currentItemIndex+1 animated:YES];
        }
        else {
            [self.iCarousel scrollToItemAtIndex:0 animated:YES];
        }

        
    }
}


- (IBAction)closePressed:(id)sender {
    
    _warningAlert = [SCLAlertView new];
    
    __weak typeof(self) weakSelf = self;
    [_warningAlert addButton:@"Quit" actionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.counDowntimer pause];
            [weakSelf stopRectProgress];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    [_warningAlert showWarning:self title:@"Quit test?" subTitle:@"You have not completed the test!" closeButtonTitle:@"Cancel" duration:0.0f];
}

- (IBAction)submitTestPressed:(id)sender {
    
    
    if (!self.isRapidFire) {
        
        [questionsMarked removeAllObjects];
        [questions enumerateObjectsUsingBlock:^(TestCardView* obj, NSUInteger idx, BOOL *stop) {
            if (obj.isMarked) {
                [questionsMarked addObject:@(idx)];
            }
        }];
        
        if (self.counDowntimer.counting && questionsMarked.count < 15) {
            // display a message box about unmarked labels
            _warningAlert = [SCLAlertView new];
            
            __weak typeof(self) weakSelf = self;
            [_warningAlert addButton:@"Submit Test" actionBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.counDowntimer pause];
                    [weakSelf stopRectProgress];
                    [weakSelf presentEvaluationScreen];
                });
            }];
            [_warningAlert showWarning:self title:@"Submit Test?" subTitle:[NSString stringWithFormat:@"You have %lu unanswered questions!",(questions.count - questionsMarked.count)] closeButtonTitle:@"Cancel" duration:0.0f];
        } else {
            [self.counDowntimer pause];
            [self stopRectProgress];
            [self presentEvaluationScreen];
        }
        
        
    } else {
        [self stopRectProgress];
        [self.counDowntimer pause];
        // handle rapid fire cases
        TestCardView *card = (TestCardView*)[self.iCarousel currentItemView];
        if (card.isAnsweredCorrectly) {
            _score++;
            _correctAnswerAlert = [SCLAlertView new];
            [_correctAnswerAlert showSuccess:self title:@"Great Work" subTitle:@"Get Ready for Next Question" closeButtonTitle:nil duration:1.0f];

            __weak typeof(self) weakSelf = self;
            [_correctAnswerAlert alertIsDismissed:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ((weakSelf.iCarousel.currentItemIndex+1) == 150) {
                        // you are a genius
                        [self presentEvaluationScreen];
                    } else {
                        [weakSelf.iCarousel scrollToItemAtIndex:self.iCarousel.currentItemIndex+1 animated:YES];
                        [weakSelf.counDowntimer reset];
                        [weakSelf.counDowntimer start];
                        [weakSelf initProgressRectWithDuration:60.0f];
                    }
                });
            }];

            
        } else {
            [self presentEvaluationScreen];
        }
        
    }
    
    
}

- (IBAction)reviewTestPressed:(id)sender {
    
    if (!_reviewPanel) {
        
        _reviewPanel = [[ModalReviewPanel alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width , self.view.frame.size.height- 150) title:@"Review Test"];
        _reviewPanel.questions = questions;
        _reviewPanel.reviewDelegate = self;
        _reviewPanel.delegate = self;
        _reviewPanel.backgroundColor = [UIColor clearColor];
        [_reviewPanel setupView];
        [self.view addSubview:_reviewPanel];
        [_reviewPanel showFromPoint:[sender center]];
        
    } else {
        [_reviewPanel hideWithOnComplete:^(BOOL finished) {
            
            [_reviewPanel removeFromSuperview];
            _reviewPanel = nil;

         }];
        
    }


}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel
{
    if (modalPanel) {
        [_reviewPanel removeFromSuperview];
        _reviewPanel = nil;
    }
}

- (void)presentEvaluationScreen
{
    
    _waitingAlert = [SCLAlertView new];
    [_waitingAlert showWaiting:self title:@"Please Wait" subTitle:@"Evaluating Test Results.." closeButtonTitle:nil duration:2.0f];
    [_waitingAlert alertIsDismissed:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            SuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TestResults"];
            vc.score = _score;
            vc.isRapidFire = _isRapidFire;
            vc.questions = questions;
            [self presentViewController:vc animated:YES completion:nil];
        });
    }];
    
    // calculate score
    if (!self.isRapidFire) {
        _score = 0;
        [questions enumerateObjectsUsingBlock:^(TestCardView* obj, NSUInteger idx, BOOL *stop) {
            if (obj.isAnsweredCorrectly) {
                _score++;
            }
        }];
    }
    

}

- (void)questionSelectedAtIndex:(NSUInteger)index
{
    [self.iCarousel scrollToItemAtIndex:index animated:YES];
}

- (void)panelWasDismissed
{
    _reviewPanel = nil;
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    SCLAlertView *timeOutAlert = [SCLAlertView new];
    [timeOutAlert showWarning:@"Oops!!!" subTitle:@"You ran out of time" closeButtonTitle:nil duration:1.0f];
    
    
    [timeOutAlert alertIsDismissed:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentEvaluationScreen];
        });
    }];

}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    
    TestCardView *card = (TestCardView*)[carousel itemViewAtIndex:carousel.currentItemIndex];


    if (![self.questionLabel.text isEqualToString:[card.object objectAtIndex:6]]) {
        
        self.questionLabel.alpha = 0.0f;
        [self.questionLabel setText:[card.object objectAtIndex:6]];
        [UIView animateWithDuration:0.3f animations:^{
            self.questionLabel.alpha = 1.0f;
            if (self.isRapidFire) {
                [self.qNumberLabel setText:[NSString stringWithFormat:@"Q. %02lu",(unsigned long)(card.objectIndex)]];
            } else {
                [self.qNumberLabel setText:[NSString stringWithFormat:@"Q. %02lu of 15",(unsigned long)card.objectIndex]];
            }
            
        }];
        
        TestCardView *prevCard = (TestCardView*)[carousel itemViewAtIndex:((carousel.currentItemIndex-1)<0?carousel.numberOfItems-1:carousel.currentItemIndex-1)];
        TestCardView *nextCard = (TestCardView*)[carousel itemViewAtIndex:((carousel.currentItemIndex+1)>carousel.numberOfItems-1?0:carousel.currentItemIndex+1)];

        [card setUserInteractionEnabled:YES];
        [card applyBlur:NO];
        
        [prevCard applyBlur:YES];
        [prevCard setUserInteractionEnabled:NO];
        [nextCard applyBlur:YES];
        [nextCard setUserInteractionEnabled:NO];

    }
    
    

}



-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)tick:(CGFloat)dt
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

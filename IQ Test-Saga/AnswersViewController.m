//
//  AnswersViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 13/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "AnswersViewController.h"
#import "TestCardView.h"
#import <StartApp/StartApp.h>
#import "AnswersCardView.h"

@interface AnswersViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *qNumberLabel;

@end

@implementation AnswersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"iqBackground.png"]]];
    //[self.view setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:244.0f/255.0f blue:237.0f/255.0f alpha:1.0]];
    
    self.iCarousel.hidden = NO;
    self.iCarousel.type = iCarouselTypeLinear;
    self.iCarousel.decelerationRate = 0.25f;
    
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.numberOfLines = 10;
    [self.questionLabel setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:17]];
    [self.questionLabel setTextColor:[UIColor whiteColor]];
    self.questionLabel.adjustsFontSizeToFitWidth = YES;
    self.questionLabel.minimumScaleFactor = 0.25f;
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)15;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
       AnswersCardView *ansCard = [AnswersCardView new];
       TestCardView *card = [self.questions objectAtIndex:index];
       ansCard.isMarked = card.isMarked;
       ansCard.isAnsweredCorrectly = card.isAnsweredCorrectly;
       ansCard.markedOption = card.markedOption;
       ansCard.object = card.object;
       ansCard.objectIndex = card.objectIndex;
        
       [ansCard setupCard];
       return ansCard;
    }
    return view;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    
    AnswersCardView *card = (AnswersCardView*)[carousel itemViewAtIndex:carousel.currentItemIndex];
    
    
    if (![self.questionLabel.text isEqualToString:[card.object objectAtIndex:6]]) {
        
        self.questionLabel.alpha = 0.0f;
        [self.questionLabel setText:[card.object objectAtIndex:6]];
        [UIView animateWithDuration:0.3f animations:^{
            self.questionLabel.alpha = 1.0f;
            [self.qNumberLabel setText:[NSString stringWithFormat:@"%02lu of 15",(unsigned long)card.objectIndex]];
        }];
        
    }
}

- (IBAction)closePressed:(id)sender {
    
    [STAStartAppAdBasic showAd];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
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

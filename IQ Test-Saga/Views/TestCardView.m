//
//  TestCardVIew.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 29/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "TestCardView.h"
#import "UIButton+Styling.h"
#import "UIImage+ImageEffects.h"

#define kiPhone6Height 667
#define kiPhone6Width  375
#define kDeviceScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kDeviceScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface TestCardView()
{
    OptionView *prevSelectedButton;
    BOOL isQuestionTrueFalse;
    NSMutableArray *optionRefs;
    UIImageView *blurView;
}
@end

@implementation TestCardView


- (instancetype)initWithQuestionArray:(NSArray*)question
{
    self = [super init];
    if (self) {
        
        self.object = question;
        self.isMarkedForReview = NO;
        self.isAnsweredCorrectly = NO;
        
        //self.layer.borderWidth = 1.0f;
        //self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 0.0f;
        self.layer.masksToBounds = YES;
        self.autoresizesSubviews = NO;
        
        optionRefs = [NSMutableArray new];

    }
    return self;
}


- (void)setupCard
{
    
    
    
    if (self.isViewAnswersMode) {
        
        self.userInteractionEnabled = NO;
        NSNumber *answerOption = [self.object objectAtIndex:1];
        
        [self applyBlur:NO];
        
        if (self.isAnsweredCorrectly) {
            
            OptionView *chkButton = [optionRefs objectAtIndex:(answerOption.intValue-1)];
//            chkButton.strokeColor = [UIColor greenColor];
//            chkButton.checkColor = [UIColor greenColor];
//            [chkButton toggleCheckState];
//            [chkButton toggleCheckState];

            
        } else {
            
            
            if (self.isMarked) {
                OptionView *markedChkButton = [optionRefs objectAtIndex:(self.markedOption-1)];
//                markedChkButton.strokeColor = [UIColor redColor];
//                markedChkButton.checkColor = [UIColor redColor];
//                [markedChkButton toggleCheckState];
//                [markedChkButton toggleCheckState];
                
                OptionView *correctChkButton = [optionRefs objectAtIndex:(answerOption.intValue-1)];
//                correctChkButton.strokeColor = [UIColor greenColor];
//                correctChkButton.checkColor = [UIColor greenColor];
//                [correctChkButton toggleCheckState];


            } else { 
                
                OptionView *correctChkButton = [optionRefs objectAtIndex:(answerOption.intValue-1)];
//                correctChkButton.checkState = OptionViewStateMixed;
//                correctChkButton.strokeColor = [UIColor greenColor];
//                correctChkButton.checkColor = [UIColor greenColor];

            }

        }
        
    } else {
        
        CGFloat xScale = kDeviceScreenWidth/kiPhone6Width;
        CGFloat yScale = kDeviceScreenHeight/kiPhone6Height;
        BOOL isiPhone4 = NO;
        //special case for iPhone 4s
        if (kDeviceScreenHeight == 480.0f) {
            isiPhone4 = YES;
            // yScale -= 0.1;
        }
        
        CGRect frame =  self.frame;
        frame.origin.x = 0;
        frame.origin.y = 00.0f;
        frame.size.width = 310*xScale;
        frame.size.height = 360*yScale;
        
        [self setFrame:frame];
        
        
//        UIImage *backgroundImage = [UIImage imageNamed:@"qbg.png"];
//        UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        backgroundImageView.image=backgroundImage;
//        [self addSubview:backgroundImageView];

        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qbg.png"]];
    
        //self.backgroundColor = [UIColor colorWithRed:215.0f/255.f green:204.0f/255.f blue:200.0f/255.f alpha:1.0f];
        self.backgroundColor = [UIColor whiteColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        if (![self.object objectAtIndex:2] || [[self.object objectAtIndex:1] isKindOfClass:[NSNull class]] || [[self.object objectAtIndex:2] isEqualToString:@"NULL"]||![self.object objectAtIndex:3] || [[self.object objectAtIndex:3] isKindOfClass:[NSNull class]] || [[self.object objectAtIndex:3] isEqualToString:@"NULL"]) {
            isQuestionTrueFalse = YES;
        }
        
        //create subviews because iCarousel fucks up with autolayouting
//        self.pageNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10*yScale, 40, 23)];
//        
//        if (self.isRapidFire) {
//            [self.pageNoLabel setText:[NSString stringWithFormat:@"%02lu",(unsigned long)(self.objectIndex)]];
//        } else {
//            [self.pageNoLabel setText:[NSString stringWithFormat:@"%02lu of 15",(unsigned long)self.objectIndex]];
//        }
//        [self.pageNoLabel sizeToFit];
//        
//        CGPoint center = self.pageNoLabel.center;
//        center.x = self.center.x;
//        self.pageNoLabel.center = center;
//        [self.pageNoLabel setTextColor:[UIColor colorWithRed:197.0f/255.0f green:152.0f/255.0f blue:119.0f/255.0f alpha:1]];
        
        UIImageView *bgImageLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0,25*yScale,60,30)];
        bgImageLabel.image = [UIImage imageNamed:@"timer1.png"];
        CGPoint center = bgImageLabel.center;
        center.x = self.center.x;
        bgImageLabel.center = center;
        //[self addSubview:bgImageLabel];
        
        
                
        CGFloat offset = isQuestionTrueFalse?15:0;
        if (isiPhone4) {
            offset -= 10;
        }
        
        CGFloat buttonWidth = (self.frame.size.width);
        CGFloat buttonHieght = self.frame.size.height/5;
        
        self.option1Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,0,buttonWidth,buttonHieght)];
        [self.option1Btn setBackgroundColor:[UIColor clearColor]];
        [self.option1Btn setText:[self.object objectAtIndex:5]];
        [self.option1Btn setTintColor:[UIColor clearColor]];
        [self.option1Btn setID:1];
        [self.option1Btn setupView];
        [self addSubview:self.option1Btn];
        
        self.option2Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,buttonHieght,buttonWidth,buttonHieght)];
        [self.option2Btn setText:[self.object objectAtIndex:4]];
        [self.option2Btn setBackgroundColor:[UIColor clearColor]];
        [self.option2Btn setTintColor:[UIColor clearColor]];
        [self.option2Btn setID:2];
        [self.option2Btn setupView];
        [self addSubview:self.option2Btn];
        
        if (!isQuestionTrueFalse) {
            self.option3Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,2*buttonHieght,buttonWidth,buttonHieght)];
            [self.option3Btn setText:[self.object objectAtIndex:3]];
            [self.option3Btn setBackgroundColor:[UIColor clearColor]];
            [self.option3Btn setID:3];
            [self.option3Btn setTintColor:[UIColor clearColor]];
            [self.option3Btn setupView];
            [self addSubview:self.option3Btn];
            
            self.option4Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,3*buttonHieght,buttonWidth,buttonHieght)];
            [self.option4Btn setText:[self.object objectAtIndex:2]];
            [self.option4Btn setBackgroundColor:[UIColor clearColor]];
            [self.option4Btn setTintColor:[UIColor clearColor]];
            [self.option4Btn setID:4];
            [self.option4Btn setupView];
            [self addSubview:self.option4Btn];
        }
        
        if (!self.isRapidFire) {
            self.markForReviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.markForReviewBtn setFrame:CGRectMake(0,4*buttonHieght,buttonWidth,buttonHieght)];
            [self.markForReviewBtn setImage:[UIImage imageNamed:@"unmarked.png"]  forState:UIControlStateNormal];
            [self.markForReviewBtn setImage:[UIImage imageNamed:@"marked.png"]  forState:UIControlStateSelected];

            [self.markForReviewBtn setTitle:@"Mark for Review" forState:UIControlStateNormal];
            [self.markForReviewBtn setTitle:@"Remove from Review" forState:UIControlStateSelected];
            
            center = self.markForReviewBtn.center;
            center.x = self.center.x;
            self.markForReviewBtn.center = center;
            self.markForReviewBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0f];
            [self.markForReviewBtn setTitleColor:[UIColor colorWithRed:238/255.0 green:142/255.0 blue:61/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self.markForReviewBtn addTarget:self action:@selector(toggleMarkForReview:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.markForReviewBtn];
        }
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.0f;
        self.layer.cornerRadius = 0.0*yScale;
        self.layer.masksToBounds = YES;
        
        [optionRefs addObject:self.option1Btn];
        [optionRefs addObject:self.option2Btn];
        if (!isQuestionTrueFalse) {
            [optionRefs addObject:self.option3Btn];
            [optionRefs addObject:self.option4Btn]; 
        }
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
        [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIColor *tintColor = [UIColor colorWithWhite:0.75 alpha:0.73];
        UIImage *blurredSnapshotImage = [snapshotImage applyBlurWithRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
        UIGraphicsEndImageContext();

        blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        blurView.image = blurredSnapshotImage;
        [self addSubview:blurView];

    }
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (kDeviceScreenHeight == 480.0f) {
        
        CGRect frame =  self.frame;
        frame.origin.x = 0;
        frame.origin.y = 25.0f;
        
        self.frame = frame;

    }
}

- (void)answerBtnPressed:(id)sender {
    
    self.isMarked = YES;
    OptionView *button = (OptionView*)sender;
    self.markedOption = button.ID;
    NSNumber *answerOption = [self.object objectAtIndex:1];
    
    if (!button.isSelected) {
        [button setIsSelected:YES];
        
        for (OptionView *button in optionRefs) {
            
            if (button != sender) {
                [button setIsSelected:NO];
            }
        }
        
    } else {
        [button setIsSelected:NO];
    }
    
    if (button.ID == answerOption.intValue) {
        self.isAnsweredCorrectly = YES;
    } else {
        self.isAnsweredCorrectly = NO;
    }
    
}

- (IBAction)toggleMarkForReview:(id)sender {
    
    self.isMarkedForReview = !self.isMarkedForReview;
    self.markForReviewBtn.highlighted = NO;
    self.markForReviewBtn.selected = !self.markForReviewBtn.selected;
    
}

- (void)applyBlur:(BOOL)apply
{
    [UIView animateWithDuration:0.75 animations:^{
        [blurView setHidden:!apply];
    }];
}

@end

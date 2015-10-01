//
//  AnswersCardView.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 7/27/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "AnswersCardView.h"
#import "UIButton+Styling.h"
#import "UIImage+ImageEffects.h"
#import "LocalStore.h"

#define kiPhone6Height 667
#define kiPhone6Width  375
#define kDeviceScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kDeviceScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface AnswersCardView()
{
    OptionView *prevSelectedButton;
    BOOL isQuestionTrueFalse;
    NSMutableArray *optionRefs;
    UIImageView *blurView;
    UILabel *explainationLabel;
    NSUInteger answerOption;
}
@end

@implementation AnswersCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 0.0f;
        self.layer.masksToBounds = YES;
        self.autoresizesSubviews = NO;
        
        

    }
    return self;
}


- (void)setupCard
{
    

        NSString *answer = [self.object objectAtIndex:1];
        answerOption = answer.integerValue - 1;
        self.markedOption--;
    
    
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
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        if (![self.object objectAtIndex:2] || [[self.object objectAtIndex:2] isKindOfClass:[NSNull class]] || [[self.object objectAtIndex:2] isEqualToString:@"NULL"]||![self.object objectAtIndex:3] || [[self.object objectAtIndex:3] isKindOfClass:[NSNull class]] || [[self.object objectAtIndex:3] isEqualToString:@"NULL"]) {
            isQuestionTrueFalse = YES;
        }
    
    
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
        [self.option1Btn setUserInteractionEnabled:NO];
        [self addSubview:self.option1Btn];
        
        self.option2Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,buttonHieght,buttonWidth,buttonHieght)];
        [self.option2Btn setText:[self.object objectAtIndex:4]];
        [self.option2Btn setBackgroundColor:[UIColor clearColor]];
        [self.option2Btn setTintColor:[UIColor clearColor]];
        [self.option2Btn setID:2];
        [self.option2Btn setupView];
        [self.option2Btn setUserInteractionEnabled:NO];
        [self addSubview:self.option2Btn];
        
        if (!isQuestionTrueFalse) {
            self.option3Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,2*buttonHieght,buttonWidth,buttonHieght)];
            [self.option3Btn setText:[self.object objectAtIndex:3]];
            [self.option3Btn setBackgroundColor:[UIColor clearColor]];
            [self.option3Btn setID:3];
            [self.option3Btn setTintColor:[UIColor clearColor]];
            [self.option3Btn setupView];
            [self.option3Btn setUserInteractionEnabled:NO];
            [self addSubview:self.option3Btn];
            
            self.option4Btn = [[OptionView alloc] initWithFrame:CGRectMake(0,3*buttonHieght,buttonWidth,buttonHieght)];
            [self.option4Btn setText:[self.object objectAtIndex:2]];
            [self.option4Btn setBackgroundColor:[UIColor clearColor]];
            [self.option4Btn setTintColor:[UIColor clearColor]];
            [self.option4Btn setID:4];
            [self.option4Btn setupView];
            [self.option4Btn setUserInteractionEnabled:NO];
            [self addSubview:self.option4Btn];
        }
        
        self.toggleExplainationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.toggleExplainationBtn setFrame:CGRectMake(0,4*buttonHieght,buttonWidth,buttonHieght)];
    
        [self.toggleExplainationBtn setTitle:@"Explanation" forState:UIControlStateNormal];
        [self.toggleExplainationBtn setTitle:@"Options" forState:UIControlStateSelected];
        
        center = self.toggleExplainationBtn.center;
        center.x = self.center.x;
        self.toggleExplainationBtn.center = center;
        self.toggleExplainationBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0f];
        [self.toggleExplainationBtn setTitleColor:[UIColor colorWithRed:238/255.0 green:142/255.0 blue:61/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.toggleExplainationBtn addTarget:self action:@selector(toggleExplaination:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.toggleExplainationBtn];
    
    
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.0f;
        self.layer.cornerRadius = 0.0*yScale;
        self.layer.masksToBounds = YES;
    
        optionRefs = [NSMutableArray new];
        [optionRefs addObject:self.option1Btn];
        [optionRefs addObject:self.option2Btn];
        if (!isQuestionTrueFalse) {
            [optionRefs addObject:self.option3Btn];
            [optionRefs addObject:self.option4Btn];
        }
    
    if (self.isAnsweredCorrectly) {
        // correct answer marked
        
        OptionView *view = [optionRefs objectAtIndex:answerOption];
        view.backgroundColor = [UIColor greenColor];
        
    }else {
        
        if (self.isMarked) {
            OptionView *incorrectView = [optionRefs objectAtIndex:self.markedOption];
            incorrectView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:44.0/255.0 blue:8.0/255.0 alpha:1.0];
            
            OptionView *correctView = [optionRefs objectAtIndex:answerOption];
            correctView.backgroundColor = [UIColor greenColor];

            
        }else {
            
            OptionView *incorrectView = [optionRefs objectAtIndex:answerOption];
            incorrectView.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:131.0/255.0 blue:48.0/255.0 alpha:0.3];

        }
        
    }
    
    NSArray *array = [[LocalStore sharedInstance]._explainations objectAtIndex:self.objectIndex];
    NSString *explainationStr = [array objectAtIndex:0];
    
    explainationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,2*buttonHieght,kDeviceScreenWidth-10,75)];
    explainationLabel.text = explainationStr;
    explainationLabel.numberOfLines = 10;
    explainationLabel.textColor = [UIColor colorWithRed:238/255.0 green:142/255.0 blue:61/255.0 alpha:1.0];
    explainationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    explainationLabel.alpha = 0.0f;
    [self addSubview:explainationLabel];

    
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


- (void)toggleExplaination:(id)sender {
    
    UIButton *senderBtn = sender;
    senderBtn.highlighted = NO;

    OptionView *correctView = [optionRefs objectAtIndex:answerOption];

    if (!senderBtn.selected) {
    
        [UIView animateWithDuration:0.2f animations:^{
            
            [optionRefs enumerateObjectsUsingBlock:^(OptionView* obj, NSUInteger idx, BOOL *stop) {
                if (!(idx == answerOption)) {
                    obj.alpha = 0.0f;
                }
            }];
            
        } completion:^(BOOL finished) {
            
            
            [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.75f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                correctView.transform = CGAffineTransformMakeTranslation(0,-correctView.frame.origin.y);
                explainationLabel.alpha = 1.0f;

            } completion:^(BOOL finished) {
                senderBtn.selected = !senderBtn.selected;
            }];
        }];
    }else {
        
        [UIView animateWithDuration:0.2f delay:0.0f usingSpringWithDamping:0.75f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            correctView.transform = CGAffineTransformIdentity;
            explainationLabel.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f animations:^{
                
                [optionRefs enumerateObjectsUsingBlock:^(OptionView* obj, NSUInteger idx, BOOL *stop) {
                    if (!(idx == answerOption)) {
                        obj.alpha = 1.0f;
                    }
                }];
                
            } completion:^(BOOL finished) {
                senderBtn.selected = !senderBtn.selected;
            }];

        }];

    }
    
}

- (void)applyBlur:(BOOL)apply
{
    [UIView animateWithDuration:0.75 animations:^{
        [blurView setHidden:!apply];
    }];
}

@end

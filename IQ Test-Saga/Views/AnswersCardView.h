//
//  AnswersCardView.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 7/27/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionView.h"

@interface AnswersCardView : UIView

@property (nonatomic, assign) BOOL isAnsweredCorrectly;
@property (nonatomic, assign) BOOL isMarked;
@property (nonatomic, assign) NSUInteger objectIndex;
@property (nonatomic, assign) NSUInteger markedOption;
@property (strong, nonatomic) NSArray *object;
@property (strong, nonatomic) OptionView *option1Btn;
@property (strong, nonatomic) OptionView *option2Btn;
@property (strong, nonatomic) OptionView *option3Btn;
@property (strong, nonatomic) OptionView *option4Btn;
@property (strong, nonatomic) UIButton *toggleExplainationBtn;

- (instancetype)initWithQuestionArray:(NSArray*)question;
- (void)setupCard;

- (IBAction)toggleMarkForReview:(id)sender;

@end

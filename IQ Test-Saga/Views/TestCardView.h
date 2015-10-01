//
//  TestCardVIew.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 29/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionView.h"

@interface TestCardView : UIView

@property (nonatomic, assign) BOOL isViewAnswersMode;
@property (nonatomic, assign) BOOL isAnsweredCorrectly;
@property (nonatomic, assign) BOOL isMarked;
@property (nonatomic, assign) BOOL isMarkedForReview;
@property (nonatomic, assign) BOOL isRapidFire;
@property (nonatomic, assign) NSUInteger indexInQArray;
@property (nonatomic, assign) NSUInteger objectIndex;
@property (nonatomic, assign) NSUInteger markedOption;
@property (strong, nonatomic) NSArray *object;
@property (strong, nonatomic) UILabel *pageNoLabel;
@property (strong, nonatomic) OptionView *option1Btn;
@property (strong, nonatomic) OptionView *option2Btn;
@property (strong, nonatomic) OptionView *option3Btn;
@property (strong, nonatomic) OptionView *option4Btn;
@property (strong, nonatomic) UIButton *markForReviewBtn;

- (instancetype)initWithQuestionArray:(NSArray*)question;
- (void)setupCard;
- (void)applyBlur:(BOOL)apply;

- (IBAction)answerBtnPressed:(id)sender;
- (IBAction)toggleMarkForReview:(id)sender;

@end

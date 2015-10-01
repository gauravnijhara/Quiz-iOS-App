//
//  OptionView.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 24/07/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "OptionView.h"
#import "TestCardView.h"

@interface OptionView()
{
    UILabel *optionIndexLabel;
    UILabel *optionTextLabel;
    UIImageView *iconImgView;
    UITapGestureRecognizer *tap;
    
}
@end

@implementation OptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)setupView {
    
    optionIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,0,20.0f,self.frame.size.height)];

    optionIndexLabel.textColor = [UIColor orangeColor];
    
    NSString *indexText = @"";
    
    switch (self.ID) {
        case 1:
            indexText = @"A) ";
            break;

        case 2:
            indexText = @"B) ";
            break;

        case 3:
            indexText = @"C) ";
            break;

        case 4:
            indexText = @"D) ";
            break;

        default:
            break;
    }
    
    optionIndexLabel.text = indexText;
    optionIndexLabel.textColor = [UIColor colorWithRed:238/255.0 green:142/255.0 blue:61/255.0 alpha:1.0];
    optionIndexLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];

    
    optionTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f,0,self.frame.size.width-50.0f, self.frame.size.height)];
    optionTextLabel.numberOfLines = 10;
    optionTextLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];
    optionTextLabel.textColor = [UIColor colorWithRed:238/255.0 green:142/255.0 blue:61/255.0 alpha:1.0];;
    optionTextLabel.minimumScaleFactor = 0.2f;
    optionTextLabel.text = self.text;

    iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
    
    CGRect iconFrame = iconImgView.frame;
    iconFrame.origin.x = self.frame.size.width - 50.0f;
    CGPoint iconCenter = iconImgView.center;
    iconCenter.y = self.center.y;
    
    iconImgView.frame = iconFrame;
    iconImgView.center = iconCenter;
    
    [self addSubview:optionIndexLabel];
    [self addSubview:optionTextLabel];
    
    
}

- (void)viewTapped:(UITapGestureRecognizer*)gesture
{
    
    TestCardView *view = (TestCardView*)self.superview;
    [view answerBtnPressed:self];
    
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRed:254/255.0 green:214/255.0 blue:196/255.0 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }

}

- (void)dealloc
{
    [self removeGestureRecognizer:tap];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

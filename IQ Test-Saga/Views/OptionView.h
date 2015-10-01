//
//  OptionView.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 24/07/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionView : UIView

@property (assign,nonatomic) NSUInteger ID;
@property (assign,nonatomic) BOOL isSelected;
@property (strong,nonatomic) NSString* text;

- (void)setupView;

@end

//
//  UIButton+Styling.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 30/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Styling)

- (void)setCurved;
- (void)setCustomFont_boldWithSize:(CGFloat)size andColor:(UIColor*)color;
- (void)setCustomFont_WithSize:(CGFloat)size andColor:(UIColor*)color;
- (void)setCustomFont_lightItalicWithSize:(CGFloat)size andColor:(UIColor*)color;
- (void)setCustomFont_ultraLightWithSize:(CGFloat)size andColor:(UIColor*)color;
- (UIImage *)imageWithColor:(UIColor *)color;
- (void) addShadowWithColor:(UIColor*)color;


@end

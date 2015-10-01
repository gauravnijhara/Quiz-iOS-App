//
//  UIButton+Styling.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 30/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "UIButton+Styling.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (Styling)

- (void)setCurved
{
    self.layer.cornerRadius = 0.0f;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth  = 2.0f;

    self.layer.masksToBounds = YES;
    
    self.titleLabel.lineBreakMode = NSLineBreakByClipping;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.minimumScaleFactor = 0.01;
    

}

- (void) addShadowWithColor:(UIColor*)color {
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowOpacity = 0.80f;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.layer.bounds] CGPath];
}

- (void)setCustomFont_boldWithSize:(CGFloat)size andColor:(UIColor*)color
{
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:image forState:UIControlStateSelected];
    
    CGSize iHave = self.frame.size;
    
    BOOL isContained = NO;
    do{
        
        CGSize constraintSize = CGSizeMake(self.frame.size.width, MAXFLOAT);

        CGRect textRect = [[self.titleLabel text] boundingRectWithSize:constraintSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName:self.titleLabel.font}
                                                     context:nil];

        if(textRect.size.width > iHave.width || textRect.size.height > iHave.height){
            self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:self.titleLabel.font.pointSize - 1];
            isContained = NO;
        }else{
            isContained = YES;
        }
        
    }while (isContained == NO);


}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setCustomFont_WithSize:(CGFloat)size andColor:(UIColor*)color
{
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];

}

- (void)setCustomFont_lightItalicWithSize:(CGFloat)size andColor:(UIColor*)color
{
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];

}

- (void)setCustomFont_ultraLightWithSize:(CGFloat)size andColor:(UIColor*)color
{
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    
}


@end

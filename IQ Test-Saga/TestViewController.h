//
//  TestViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 28/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "MZTimerLabel.h"

@interface TestViewController : UIViewController

@property (nonatomic, assign) BOOL isRapidFire;
@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@end

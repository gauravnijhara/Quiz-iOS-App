//
//  AnswersViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 13/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface AnswersViewController : UIViewController

@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (strong, nonatomic) NSMutableArray *questions;

@end

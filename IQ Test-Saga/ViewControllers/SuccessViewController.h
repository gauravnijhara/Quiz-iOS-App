//
//  SuccessViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 01/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface SuccessViewController : UIViewController

@property (assign, nonatomic) BOOL isRapidFire;
@property (assign, nonatomic) int score;
@property (strong, nonatomic) NSArray* questions;
@property (weak, nonatomic) IBOutlet UILabel *testResultsLabel;
@property (strong, nonatomic) FBSDKLikeControl *likeButton;
@property (strong, nonatomic) FBSDKShareButton *shareButton;

@end

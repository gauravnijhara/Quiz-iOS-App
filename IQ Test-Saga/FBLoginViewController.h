//
//  ViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 24/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBLoginViewController : UIViewController

@property (nonatomic,assign) BOOL  skipNeeded;
@property (nonatomic,weak) IBOutlet FBSDKLoginButton *loginButton;
@property (nonatomic,weak) IBOutlet UIButton *skipButton;

@end


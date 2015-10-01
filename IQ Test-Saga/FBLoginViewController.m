//
//  ViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 24/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "FBLoginViewController.h"
#import "UIViewController+MaterialDesign.h"
#import "LocalStore.h"
#import "User.h"

@interface FBLoginViewController ()<FBSDKLoginButtonDelegate>

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.loginButton.center = self.view.center;
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.loginButton.delegate = self;
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect frame = self.skipButton.frame;
    frame.size = self.loginButton.frame.size;
    self.skipButton.frame = frame;
    
}


- (IBAction)skipPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
   
    if (!error) {
        [[User sharedInstance] fetchUserInfoUsingResultsArray:result];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [[User sharedInstance] logoutUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end

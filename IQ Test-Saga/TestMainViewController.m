//
//  TestMainViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "TestMainViewController.h"
#import "TestViewController.h"
#import "SCLAlertView.h"
#import <StartApp/StartApp.h>

@interface TestMainViewController()
{
    SCLAlertView *_testStartAlert;
    STABannerView* bannerView;


}
@property (weak, nonatomic) IBOutlet UIButton *iqTestButton;
@property (weak, nonatomic) IBOutlet UIButton *rapidFireButton;



@end

@implementation TestMainViewController

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.iqTestButton.layer.borderWidth = 2.0f;
    self.iqTestButton.layer.cornerRadius = 18.0f;
    self.iqTestButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.rapidFireButton.layer.borderWidth = 2.0f;
    self.rapidFireButton.layer.cornerRadius = 18.0f;
    self.rapidFireButton.layer.borderColor = [[UIColor whiteColor] CGColor];

    
    

    [[self navigationController] setNavigationBarHidden:YES animated:NO];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (bannerView == nil) {
        bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize origin:CGPointMake(25, 25)
                                                withView:self.view withDelegate:nil];
        [self.view addSubview:bannerView];
    }

}

- (void) viewDidLayoutSubviews {
    
    [self.view bringSubviewToFront:bannerView];
    
    [super viewDidLayoutSubviews];
    
}

- (IBAction)startIQTest:(id)sender {
    
    _testStartAlert = nil;
    _testStartAlert = [[SCLAlertView alloc]init];
    
    TestViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TestVC"];
    vc.isRapidFire = NO;

    __weak typeof(self) weakSelf = self;
    [_testStartAlert addButton:@"Start Test" actionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:vc animated:YES completion:^{
                
            }];
        });
    }];

    [_testStartAlert showInfo:self title:@"Start" subTitle:@"The timer will start ticking after you press \"Start\" . Are you ready? " closeButtonTitle:@"Cancel" duration:0.0f];

    [_testStartAlert alertIsDismissed:^{
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    }];
    
    
}
- (IBAction)startIQRapidFireTest:(id)sender {
    
    
    _testStartAlert = nil;
    _testStartAlert = [[SCLAlertView alloc]init];
    
    
    
    __weak typeof(self) weakSelf = self;
    [_testStartAlert addButton:@"Start Test" actionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TestViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TestVC"];
            vc.isRapidFire = YES;
            [weakSelf presentViewController:vc animated:YES completion:nil];

                
        });
    }];
            
    [_testStartAlert showInfo:self title:@"Start" subTitle:@"The timer will start ticking after you press \"Start\". Are you ready? " closeButtonTitle:@"Cancel" duration:0.0f];

    
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end

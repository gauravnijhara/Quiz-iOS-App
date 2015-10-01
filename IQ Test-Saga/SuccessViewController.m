//
//  SuccessViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 01/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "SuccessViewController.h"
#import "TestViewController.h"
#import "LocalStore.h"
#import "User.h"
#import "AnswersViewController.h"
#import "iRate.h"
#import <StartApp/StartApp.h>


@interface SuccessViewController()
{
    int IQ;
    NSString *categoryString;
}
@property (weak, nonatomic) IBOutlet UIButton *viewAnswersBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@end

@implementation SuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [STAStartAppAdBasic showAd];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        if (![iRate sharedInstance].ratedThisVersion) {
            [[iRate sharedInstance] promptForRating];
        }

    });

    //store results and display
    [self calulateIQ:self.score];
    
    if (!self.isRapidFire) {
        [[LocalStore sharedInstance] insertScoreForHistory:IQ intoRecordType:@"IQ"];
        [self.testResultsLabel setText:[NSString stringWithFormat:@"You answered %d questions out of 15 correctly. \n Your I.Q. is %d .\n %@",self.score,IQ,categoryString]];
    } else {
        [[LocalStore sharedInstance] insertScoreForHistory:IQ intoRecordType:@"IQRF"];
        [self.testResultsLabel setText:[NSString stringWithFormat:@"You answered %d questions correctly. \n Your I.Q. is %d .\n %@",self.score,IQ,categoryString]];
    }
    
    

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self addFBShareAndLikeButtons];
}

- (void)viewWillLayoutSubviews
{
    if (self.isRapidFire) {
        self.widthConstraint.constant = self.view.frame.size.width;
        [self.viewAnswersBtn removeFromSuperview];
    }
    
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews
{
    
    if (!self.likeButton && !self.shareButton) {
        [self addFBShareAndLikeButtons];
        
        [self.view bringSubviewToFront:self.shareButton];
        [self.view bringSubviewToFront:self.likeButton];

    }
    
    [super viewDidLayoutSubviews];

}
- (void)calulateIQ:(int)score
{
    int sum = score * 4;
    
    if (sum == 60)
    {
        IQ = arc4random_uniform(6) + 155;
        categoryString =  @"You fall in the category of 'GENIUS'.";
        
    }
    else if (sum == 56)
    {
        IQ = arc4random_uniform(10) + 145;
        categoryString =  @"You fall in the category of 'Gifted'.";
        
    }
    else if (sum == 52 || sum == 48)
    {
        IQ = arc4random_uniform(10) + 135;
        categoryString =  @"You fall in the category of 'Very Superior'.";
        
    }
    else if (sum == 44 || sum == 40)
    {
        
        IQ = arc4random_uniform(10) + 125;
        categoryString =  @"You fall in the category of 'Superior'.";
        
    }
    else if (sum == 36 || sum == 32)
    {
        
        IQ = arc4random_uniform(10) + 115;
        categoryString =  @"You fall in the category of 'Average'.";
        
    }
    else if (sum == 28 || sum == 24)
    {
        IQ = arc4random_uniform(10) + 105;
        categoryString =  @"You fall in the category of 'Normals'.";
    }
    else if (sum == 20 || sum == 16 || sum == 12)
    {
        IQ = arc4random_uniform(10) + 85;
        categoryString =  @"You fall in the category of 'Below Normals'.";
    }
    
    else if (sum == 8 || sum==4)
    {
        IQ = arc4random_uniform(10) + 65;
        categoryString =  @"You fall in the category of 'Feeble-Minded'.";
    }
    
    else if (sum == 0)
    {
        IQ = arc4random_uniform(5) + 50;
        categoryString =  @"Try again for better results :)";
    }
}

- (void)addFBShareAndLikeButtons
{
    CGRect frame;
    
    self.likeButton = [FBSDKLikeControl new];
    self.likeButton.objectID = @"https://www.facebook.com/pages/iPhone-Application-Development/127517843995233";
    frame = self.likeButton.frame;
    frame.origin.y = self.view.frame.size.height - 150;
    frame.origin.x = 50;
    self.likeButton.frame = frame;
    self.likeButton.enabled = YES;
    [self.view addSubview:self.likeButton];
    
    
    self.shareButton = [FBSDKShareButton new];
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://www.facebook.com/pages/iPhone-Application-Development/127517843995233"];
    content.contentTitle = @"IQ Test Score";
    content.contentDescription = [NSString stringWithFormat:@"Hey my IQ is %d , What's yours?",IQ];
    
    self.shareButton.shareContent = content;
    frame = self.shareButton.frame;
    frame.origin.y = self.view.frame.size.height - 150;
    frame.origin.x = self.view.frame.size.width-50;
    self.shareButton.frame = frame;
    [self.view addSubview:self.shareButton];



}

- (IBAction)backPressed:(id)sender {
    
//    UINavigationController *navVC =  [vc viewControllers][0];
//    [navVC popToRootViewControllerAnimated:NO];
    
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)viewAnswersPressed:(id)sender {
    
    AnswersViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AnswersVC"];
    vc.questions =  [[NSMutableArray alloc] initWithArray:self.questions copyItems:NO];
    [vc.iCarousel reloadData];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end

//
//  UserProfileViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 06/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "UserProfileViewController.h"
#import "User.h"
#import "FBLoginViewController.h"
#import <StartApp/StartApp.h>

@interface UserProfileViewController ()<FBSDKLoginButtonDelegate>
{
    STABannerView* bannerView;

}
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbButton;

@end


@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.fbButton.delegate = self;
    
//    if (![User sharedInstance].isLoggedIn) {
//        // show fb login window
//        //fbLoginVC
//        FBLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fbLoginVC"];
//        
//        [self presentViewController:vc animated:YES completion:^(void){
//        }];
//        
//    }

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([User sharedInstance].isLoggedIn) {
        // show fb login window
        [self fillDetails];
        self.viewHistoryBtn.hidden = NO;

    } else {
        self.viewHistoryBtn.hidden = YES;
        
    }
    
    if (bannerView == nil) {
        
        bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize origin:CGPointMake(25,25)
                      
                                                withView:self.view withDelegate:nil];
        
        [self.view addSubview:bannerView];
        
    }

    
}

- (void) viewDidLayoutSubviews {
    
    [self.view bringSubviewToFront:bannerView];
    
    [super viewDidLayoutSubviews];
    
}


- (void)fillDetails
{
    if (![User sharedInstance].name) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary* result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     [STAStartAppAdBasic showAd];
                     
                     self.userFullName.text = [result objectForKey:@"name"];
                     self.userEmailID.text = [result objectForKey:@"email"];
                     [User sharedInstance].name = [result objectForKey:@"name"];
                     [User sharedInstance].email = [result objectForKey:@"email"];
                     [[User sharedInstance] saveUser];
                 });
             } else {
                 self.userFullName.text = @"User Name";
                 self.userEmailID.text = @"User Email ID";
 
             }
         }];

    } else {
        
        self.userFullName.text = [User sharedInstance].name;
        self.userEmailID.text = [User sharedInstance].email;

    }
    
    if (![User sharedInstance].profileImage) {
        FBSDKGraphRequest *dpRequest = [[FBSDKGraphRequest alloc]
                                        initWithGraphPath:@"/me?fields=picture.type(large)"
                                        parameters:nil
                                        HTTPMethod:@"GET"];

        [dpRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                id result,
                                                NSError *error) {
            
            if (!error) {
                
                NSDictionary *dict = (NSDictionary *)result;
                NSString *url  = dict[@"picture"][@"data"][@"url"];

                NSError *requestError;
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
                
                NSURLResponse *res;
                NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&res error:&requestError];
                
                if(!response) {
                    return;
                }
                
                
                UIImage *img = [UIImage imageWithData:response];

                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userDp.image  = img;
                    [User sharedInstance].profileImage = img;
                    [[User sharedInstance] saveUser];
                });
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userDp.image  = nil;
                });

            }
            // Handle the result
        }];
    } else {
        self.userDp.image  = [User sharedInstance].profileImage;

    }
    
    
}
- (IBAction)viewHistoryBtnTapped:(id)sender {
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if (!error) {
        [[User sharedInstance] fetchUserInfoUsingResultsArray:result];
        [self fillDetails];
    }

}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
    [[User sharedInstance] logoutUser];
    [self fillDetails];
    FBLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fbLoginVC"];
    
    [self presentViewController:vc animated:YES completion:^(void){
    }];

    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

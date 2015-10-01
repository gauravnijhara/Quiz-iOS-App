//
//  AppDelegate.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 24/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "FBLoginViewController.h"
#import "User.h"
#import "TestMainViewController.h"
#import "LocalStore.h"
#import "iRate.h"
#import <Tapjoy/Tapjoy.h>
#import <StartApp/StartApp.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


+(void) initialize {
    [super initialize];
    [iRate sharedInstance].usesUntilPrompt = 10;
    [iRate sharedInstance].daysUntilPrompt = 0.08;
    [iRate sharedInstance].remindPeriod = 1;
    [iRate sharedInstance].promptForNewVersionIfUserRated = YES;
    
    [[iRate sharedInstance] setAppStoreCountry:@"in"];
    [[iRate sharedInstance] setVerboseLogging:NO];
    
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    [iRate sharedInstance].applicationBundleID = bundleIdentifier;
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    //enable preview mode
    [iRate sharedInstance].previewMode = NO;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setStatusBarHidden:YES];

    // Override point for customization after application launch.
    [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    
    
    //The Tapjoy connect call
    [Tapjoy connect:@"in2iIS0bSoOOYy3mawjVZwEB3wi527FjPanZVtfHmzD9UOCCZdUb1lQpGtd6"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBarBG.png"]];
//    [tabBarController.tabBar.backgroundView addSubview:bgImageView];
    tabBarController.tabBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    
    [self setupRootViewController:tabBarController];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    [[LocalStore sharedInstance] loadData];
    
    if (![User sharedInstance].isLoggedIn) {
        // show fb login window
        //fbLoginVC
        FBLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fbLoginVC"];
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        
    }

    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.devID = @"105972705";
    sdk.appID = @"205050464";
    
    //[sdk showSplashAd];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
    
    return YES;
}

- (void)setupRootViewController:(RDVTabBarController*)tabBarController
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *testNavController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"testsNavController"];
    UINavigationController *instructionsNavController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"instructionsNavController"];
    UINavigationController *historyNavController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"historyNavController"];
//    UINavigationController *userProfileNavController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"userProfileNavController"];
    UINavigationController *moreOptionsNavController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"moreOptionsNavVC"];


    [tabBarController setViewControllers:@[testNavController,instructionsNavController,historyNavController,moreOptionsNavController]];
    
    RDVTabBar *tabBar = [tabBarController tabBar];
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 63)];
    
    RDVTabBarItem *firstItem = (RDVTabBarItem*)[tabBarController tabBar].items[0];
    RDVTabBarItem *secondItem = (RDVTabBarItem*)[tabBarController tabBar].items[1];
    RDVTabBarItem *thirdItem = (RDVTabBarItem*)[tabBarController tabBar].items[2];
    RDVTabBarItem *fourthItem = (RDVTabBarItem*)[tabBarController tabBar].items[3];
    //RDVTabBarItem *fifthItem = (RDVTabBarItem*)[tabBarController tabBar].items[4];

    NSDictionary *unselectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:155.0/255.0f green:155.0/255.0f blue:155.0/255.0f alpha:1.0f]};

    NSDictionary *selectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0f green:175.0/255.0f blue:75.0/255.0f alpha:1.0f]};

    firstItem.title = @"Test";
    secondItem.title = @"Instructions";
    thirdItem.title = @"History";
    fourthItem.title = @"More";
    //fifthItem.title = @"More";

    firstItem.unselectedTitleAttributes = unselectedTitleAttributes;
    firstItem.selectedTitleAttributes = selectedTitleAttributes;
    secondItem.unselectedTitleAttributes = unselectedTitleAttributes;
    secondItem.selectedTitleAttributes = selectedTitleAttributes;
    thirdItem.unselectedTitleAttributes = unselectedTitleAttributes;
    thirdItem.selectedTitleAttributes = selectedTitleAttributes;
    fourthItem.unselectedTitleAttributes = unselectedTitleAttributes;
    fourthItem.selectedTitleAttributes = selectedTitleAttributes;
    //fifthItem.unselectedTitleAttributes = unselectedTitleAttributes;
    //fifthItem.selectedTitleAttributes = selectedTitleAttributes;

    [firstItem setFinishedSelectedImage:[UIImage imageNamed:@"testicon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"testicon_us.png"]];
    [secondItem setFinishedSelectedImage:[UIImage imageNamed:@"instructionsicon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"instructions_us.png"]];
    [thirdItem setFinishedSelectedImage:[UIImage imageNamed:@"historyicon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"history_us.png"]];
//    [fourthItem setFinishedSelectedImage:[UIImage imageNamed:@"userIcon_us.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"userIcon.png"]];
    [fourthItem setFinishedSelectedImage:[UIImage imageNamed:@"moreicon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"moreicon_us.png"]];


    

}
@end

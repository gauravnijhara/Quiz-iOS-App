//
//  CustomModal.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 13/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "CustomModal.h"
#import "RDVTabBarController.h"

@implementation CustomModal

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    RDVTabBarController *parentvc = (RDVTabBarController*)sourceViewController.presentingViewController;
    UINavigationController *navVC = parentvc.viewControllers[0];
    
   // [navVC.viewControllers objectAtIndex:0]
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [sourceViewController.view.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:keyWindow.frame];
    imgView.image = capturedScreen;
    [keyWindow addSubview:imgView];
    
    
    [sourceViewController dismissViewControllerAnimated:NO completion:nil];
    
    [[navVC.viewControllers objectAtIndex:0] presentViewController:destinationViewController animated:YES completion:nil];
    
    

}

@end

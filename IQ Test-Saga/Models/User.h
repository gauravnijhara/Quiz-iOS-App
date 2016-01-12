//
//  User.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 06/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface User: NSObject<NSCoding>

@property (nonatomic, copy)   NSString *name;

@property (nonatomic, copy)   NSString *email;

@property (nonatomic, copy)   UIImage *profileImage;

@property (nonatomic , assign , getter=isLoggedIn) BOOL loggedIn;

+ (User*)sharedInstance;

-(void)saveUser;

-(void)logoutUser;

-(void)fetchUserInfoUsingResultsArray:(FBSDKLoginManagerLoginResult*)result;

@end

//
//  User.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 06/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "User.h"

@implementation User

+ (User*)sharedInstance
{
    static User* user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!user) {
            NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData *savedUserData = [currentDefaults objectForKey:@"UserInstance"];
            if(savedUserData) {
                user = [NSKeyedUnarchiver unarchiveObjectWithData:savedUserData];
            }
            if (!user) {
                user = [[User alloc] init];
            }
            
            if ([FBSDKAccessToken currentAccessToken]) {
                user.loggedIn = YES;
            }
            
        }
    });
    return user;
}


-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"userName"];
    [aCoder encodeObject:self.email forKey:@"userEmail"];
    [aCoder encodeObject:UIImagePNGRepresentation(self.profileImage) forKey:@"profileImage"];

}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"userName"];
        self.email = [aDecoder decodeObjectForKey:@"userEmail"];
        self.profileImage =  [UIImage imageWithData: [aDecoder decodeObjectForKey:@"profileImage"]];
    }
    return self;
}

-(void)fetchUserInfoUsingResultsArray:(FBSDKLoginManagerLoginResult*)result
{
    
    self.loggedIn = YES;
// no need of profile image

}

-(void)saveUser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:@"UserInstance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });

}

-(void)logoutUser
{
    self.email = nil;
    self.name = nil;
    self.profileImage = nil;
    self.loggedIn = NO;
    [self saveUser];
}

@end

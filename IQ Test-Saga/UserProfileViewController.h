//
//  UserProfileViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 06/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userDp;
@property (weak, nonatomic) IBOutlet UILabel *userFullName;
@property (weak, nonatomic) IBOutlet UILabel *userEmailID;
@property (weak, nonatomic) IBOutlet UIButton *viewHistoryBtn;

@end

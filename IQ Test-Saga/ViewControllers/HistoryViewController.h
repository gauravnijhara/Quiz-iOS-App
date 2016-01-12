//
//  HistoryViewController.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *iqTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *iqRapidFireBtn;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

@end

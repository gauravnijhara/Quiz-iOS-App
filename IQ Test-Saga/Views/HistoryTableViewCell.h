//
//  HistoryTableViewCell.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 02/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) NSArray *historyPrevObject;
@property (strong, nonatomic) NSArray *historyCurObject;

- (void)setupCell;

@end

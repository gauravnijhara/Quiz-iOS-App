//
//  HistoryTableViewCell.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 02/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "HistoryTableViewCell.h"

@interface HistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *upDownArrow;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation HistoryTableViewCell

- (void)setupCell
{
    
    NSString *dateString = [self.historyCurObject objectAtIndex:1];
    int score = ((NSNumber*)[self.historyCurObject objectAtIndex:2]).intValue;

    [self.dateLabel setText:dateString];
    
    if (!self.historyPrevObject) {
        [self.upDownArrow setHidden:YES];
    } else {
        int prevScore = ((NSNumber*)[self.historyPrevObject objectAtIndex:2]).intValue;
        if (prevScore > score) {
            [self.upDownArrow setHidden:NO];
            [self.upDownArrow setImage:[UIImage imageNamed:@"downwhite.png"]];
        } else if (prevScore < score) {
            [self.upDownArrow setHidden:NO];
            [self.upDownArrow setImage:[UIImage imageNamed:@"upwhite.png"]];
        } else {
            [self.upDownArrow setHidden:YES];
        }
    }
    
    [self.scoreLabel setText:[NSString stringWithFormat:@"I.Q. : %d",score]];
    
    // add seperator
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 0.5, self.frame.size.width - 40, 0.5)];
    seperator.backgroundColor = [UIColor whiteColor];
    [self addSubview:seperator];
}

@end

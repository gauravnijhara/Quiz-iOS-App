//
//  HistoryViewController.m

//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "LocalStore.h"

@interface HistoryViewController()
{
    NSArray *_resultList;
}
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.iqTestBtn setSelected:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self.iqTestBtn setTitle:@"IQ TEST" forState:UIControlStateNormal];
    [self.iqRapidFireBtn setTitle:@"RAPID FIRE" forState:UIControlStateNormal];
    
    [self.iqTestBtn setTitleColor:[UIColor colorWithRed:241.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    [self.iqTestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.iqTestBtn setBackgroundColor:[UIColor whiteColor]];
    self.iqTestBtn.layer.borderWidth = 1.0f;
    self.iqTestBtn.layer.cornerRadius = 14.0f;
    self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.iqRapidFireBtn setTitleColor:[UIColor colorWithRed:241.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    [self.iqRapidFireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[LocalStore sharedInstance] repopulateHistoryTables];
    
    if (self.iqTestBtn.selected) {
        _resultList = [LocalStore sharedInstance]._IQHistory;

    } else {
        _resultList = [LocalStore sharedInstance]._IQRFHistory;
    }
    [self.resultsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    cell.historyCurObject = [_resultList objectAtIndex:indexPath.row];
    cell.historyPrevObject = nil;
    
    if (_resultList.count > 1 && !((_resultList.count - 1) == indexPath.row)) {
        cell.historyPrevObject = [_resultList objectAtIndex:(indexPath.row+1)];
    }
    
    [cell setupCell];

    return cell;
}

- (IBAction)toggleInstructions:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    if (button.tag == 0) {
        if (!self.iqTestBtn.selected) {
            [self.iqTestBtn setSelected:YES];
            [self.iqRapidFireBtn setSelected:NO];
            _resultList = [LocalStore sharedInstance]._IQHistory;
            [self.resultsTableView reloadData];
            
            [self.iqTestBtn setBackgroundColor:[UIColor whiteColor]];
            self.iqTestBtn.layer.borderWidth = 1.0f;
            self.iqTestBtn.layer.cornerRadius = 14.0f;
            self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [self.iqRapidFireBtn setBackgroundColor:[UIColor clearColor]];
            self.iqRapidFireBtn.layer.borderWidth = 0.0f;
            self.iqRapidFireBtn.layer.cornerRadius = 14.0f;
            self.iqRapidFireBtn.layer.borderColor = [[UIColor whiteColor] CGColor];

        }
        
    } else {
        if (!self.iqRapidFireBtn.selected) {
            [self.iqTestBtn setSelected:NO];
            [self.iqRapidFireBtn setSelected:YES];
            _resultList = [LocalStore sharedInstance]._IQRFHistory;
            [self.resultsTableView reloadData];
            
            [self.iqTestBtn setBackgroundColor:[UIColor clearColor]];
            self.iqTestBtn.layer.borderWidth = 0.0f;
            self.iqTestBtn.layer.cornerRadius = 14.0f;
            self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [self.iqRapidFireBtn setBackgroundColor:[UIColor whiteColor]];
            self.iqRapidFireBtn.layer.borderWidth = 1.0f;
            self.iqRapidFireBtn.layer.cornerRadius = 14.0f;
            self.iqRapidFireBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        }
    }
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end

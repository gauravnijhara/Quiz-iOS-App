//
//  LocalStore.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "LocalStore.h"

@implementation LocalStore

+ (LocalStore*)sharedInstance
{
    static LocalStore* store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!store) {
            store = [[LocalStore alloc] init];
            store._IQRFHistory = [NSMutableArray new];
            store._IQHistory = [NSMutableArray new];
        }
    });
    return store;
}

-(void)loadData{
    
    [LocalStore sharedInstance].dbManager = [[DBManager alloc] initWithDatabaseFilename:@"IQTestSagaPro"];

    // Form the query.
    NSString *query = @"select * from IQTestSagaPro";
    
    // Get the results.
    if ([LocalStore sharedInstance]._testQuestions != nil) {
        [LocalStore sharedInstance]._testQuestions = nil;
    }
    
    //explanation
    [LocalStore sharedInstance]._testQuestions = [[NSArray alloc] initWithArray:[[LocalStore sharedInstance].dbManager loadDataFromDB:query]];
    [LocalStore sharedInstance]._allHistory = [[NSArray alloc] initWithArray:[[LocalStore sharedInstance].dbManager loadDataFromDB:@"select * from TestHistory"]];
    [LocalStore sharedInstance]._explainations = [[NSArray alloc] initWithArray:[[LocalStore sharedInstance].dbManager loadDataFromDB:@"select explanation from IQTestSagaPro"]];

    NSArray *tempArr = [[NSArray alloc] initWithArray:[[LocalStore sharedInstance].dbManager loadDataFromDB:@"select * from RandomOrder"]];
    
    [tempArr enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL *stop) {
        
        [[LocalStore sharedInstance]._order addObject:[obj objectAtIndex:0]];
        
    }];
    
    //process history
    [[LocalStore sharedInstance]._allHistory enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL *stop) {
        if ([[obj objectAtIndex:0] isEqualToString:@"IQNormal"]) {
            [[LocalStore sharedInstance]._IQHistory addObject:obj];
        } else {
            [[LocalStore sharedInstance]._IQRFHistory addObject:obj];
        }
    }];
    
    
}

- (void)recreateRandomOrderWithForce:(BOOL)forceRecreate
{
    // process random order
    if ([LocalStore sharedInstance]._order.count == 0 || forceRecreate) {
        //randomise list and add to db
        //add indices 1 to 150
        NSMutableArray *arr = [NSMutableArray new];
        for(int i = 0 ; i < 150 ; i++)
            [arr addObject:[NSNumber numberWithInt:i]];
        
        for (NSUInteger i = 0; i < 150; ++i) {
            // Select a random element between i and end of array to swap with.
            NSUInteger nElements = 150 - i;
            NSUInteger n = (arc4random() % nElements) + i;
            [arr exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        
        for (int i = 0; i < 150; i++) {
            // Execute the query.
            NSNumber *num = (NSNumber*)arr[i];
            [[LocalStore sharedInstance].dbManager executeQuery:[NSString stringWithFormat:@"insert into 'RandomOrder' values(%d)",num.intValue]];
            
        }
        
        [[LocalStore sharedInstance]._order removeAllObjects];
        [LocalStore sharedInstance]._order = arr;
    }
    
}

- (void)insertScoreForHistory:(NSUInteger)score intoRecordType:(NSString*)recordType
{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterMediumStyle
                                                          timeStyle:NSDateFormatterShortStyle];

    [[LocalStore sharedInstance].dbManager executeQuery:[NSString stringWithFormat:@"insert into 'TestHistory' values('%@','%@',%d,%d)",recordType,dateString,(int)score,(int)[LocalStore sharedInstance]._allHistory.count+1]];
    
    [LocalStore sharedInstance]._allHistory = [[NSArray alloc] initWithArray:[[LocalStore sharedInstance].dbManager loadDataFromDB:@"select * from TestHistory"]];

}

- (void)repopulateHistoryTables
{
    
    [[LocalStore sharedInstance]._IQHistory removeAllObjects];
    [[LocalStore sharedInstance]._IQRFHistory removeAllObjects];
    
    NSMutableArray *tempIQ = [NSMutableArray new];
    NSMutableArray *tempIQRF = [NSMutableArray new];
    
   [[LocalStore sharedInstance]._allHistory enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL *stop) {
       
       if ([[obj objectAtIndex:0] isEqualToString:@"IQ"]) {
           [tempIQ addObject:obj.copy];
       }
       
       if ([[obj objectAtIndex:0] isEqualToString:@"IQRF"]) {
           [tempIQRF addObject:obj.copy];
       }

   }];
    
    [LocalStore sharedInstance]._IQHistory = [[tempIQ reverseObjectEnumerator] allObjects].mutableCopy;
    [LocalStore sharedInstance]._IQRFHistory = [[tempIQRF reverseObjectEnumerator] allObjects].mutableCopy;
    
    
}

@end

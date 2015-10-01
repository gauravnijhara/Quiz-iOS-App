//
//  LocalStore.h
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface LocalStore : NSObject


@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray* _testQuestions;
@property (nonatomic, strong) NSArray* _allHistory;
@property (nonatomic, strong) NSArray* _explainations;
@property (nonatomic, strong) NSMutableArray* _IQHistory;
@property (nonatomic, strong) NSMutableArray* _IQRFHistory;
@property (nonatomic, strong) NSMutableArray* _order;

+ (LocalStore*)sharedInstance;

-(void)loadData;
- (void)insertScoreForHistory:(NSUInteger)score intoRecordType:(NSString*)recordType;
- (void)repopulateHistoryTables;
- (void)recreateRandomOrderWithForce:(BOOL)forceRecreate;

@end

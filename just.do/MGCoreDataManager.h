//
//  MGDataManager.h
//  just.do
//
//  Created by Marcus Grant on 8/3/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


extern NSString * const DataManagerDidSaveNotification;
extern NSString * const DataManagerDidSaveFailedNotification;

@interface MGCoreDataManager : NSObject



@property (nonatomic, readonly, retain) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, retain) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, retain)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(MGCoreDataManager *)sharedInstance;
-(BOOL)save;
-(NSManagedObjectContext*)managedObjectContext;

@end



//
//  MGDataManager.m
//  just.do
//
//  Created by Marcus Grant on 8/3/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "MGCoreDataManager.h"

NSString * const DataManagerDidSaveNotification = @"DataManagerDidSaveNotification";
NSString * const DataManagerDidSaveFailedNotification = @"DataManagerDidSaveFailedNotification";

@interface MGCoreDataManager ()

- (NSString*)sharedDocumentsPath;

@end

@implementation MGCoreDataManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainObjectContext = _mainObjectContext;
@synthesize objectModel = _objectModel;

NSString * const DM_BUNDLE_NAME = @"TaskStore";
NSString * const DM_MODEL_NAME = @"TaskModel";
NSString * const DM_SQL_LITE_PATH = @"TaskStore.sqlite";

//Singleton Creator
+(MGCoreDataManager *)sharedInstance
{
    static dispatch_once_t singleton;
    static MGCoreDataManager *sharedInstance = nil;
    
    dispatch_once(&singleton, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

///////NOT SURE I CAN MAKE THIS WORK WITH ARC
//- (void)dealloc {
//    [self save];
//    
//    [_persistentStoreCoordinator release];
//    [_mainObjectContext release];
//    [_objectModel release];
//    
//    [super dealloc];
//}

//create and return the object model
-(NSManagedObjectModel*)objectModel
{
    if (_objectModel)
        return _objectModel;
    
    //create a bundle and proceed so long as there is a bundle name defined
    NSBundle *bundle = [NSBundle mainBundle];
    if (DM_BUNDLE_NAME)
    {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:DM_BUNDLE_NAME ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    
    //set the model path
    NSString *modelPath = [bundle pathForResource:DM_MODEL_NAME ofType:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    
    return _objectModel;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator)
        return _persistentStoreCoordinator;
    
   //Create string to store path to sqlite store and set it as a url to the store
    NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:DM_SQL_LITE_PATH];
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    //create the migration and mapping aptions
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    //Try to load the store
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
        NSLog(@"Fatal error while creating persistent store: %@", error);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

//TODO: change this to be performed on a back thread if performance becomes a problem
-(NSManagedObjectContext*)mainObjectContext
{
    if (_mainObjectContext)
        return _mainObjectContext;
    
    //create the context on the main thread, I will probably change this to back thread eventually
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(mainObjectContext)
                               withObject:nil
                            waitUntilDone:YES];
        return _mainObjectContext;
    }
    
    _mainObjectContext = [[NSManagedObjectContext alloc] init];
    [_mainObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return _mainObjectContext;
}

//save the managed object context associated with this manager to 
-(BOOL)save
{
    //No need to save the context if the saved context is no different from the one in memory
    if (![self.mainObjectContext hasChanges])
        return YES;
    
    //save the context otherwise
    //If an error occurs log it, and indicate it with NSError and NSNotificationCenter
    NSError *error = nil;
    if (![self.mainObjectContext save:&error]) {
        NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
        [[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveFailedNotification
                                                            object:error];
        return NO;
    }
    
    //post save notification if succesful
    [[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveNotification object:nil];
    return YES;
}

//return the correct string for shared docs
-(NSString *)sharedDocumentsPath
{
    //not sure
    static NSString *sharedDocumentsPath = nil;
    if (sharedDocumentsPath)
        return sharedDocumentsPath;
    
    //create the path to the database directory - had to remove a retain call from this, might cause probs?
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    sharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database"];
    
    //check that the DB acxtually exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![fileManager fileExistsAtPath:sharedDocumentsPath isDirectory:&isDirectory] || !isDirectory)
    {
        NSError *error = nil;
        NSDictionary *managerAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                                      forKey:NSFileProtectionKey];
        [fileManager createDirectoryAtPath:sharedDocumentsPath
               withIntermediateDirectories:YES
                                attributes:managerAttributes
                                     error:&error];
        if (error)
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
    }
    
    return sharedDocumentsPath;
}

//get the managed object context from the data store
-(NSManagedObjectContext*)managedObjectContext
{
    //create the managed object context for the singleton, BTW autorelease was here before but not supported with ARC
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
    [moc setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return moc;
}


@end

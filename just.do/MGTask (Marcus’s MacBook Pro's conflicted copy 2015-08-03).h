//
//  DMTask.h
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+MGMethods.h"

#pragma constants

//extern NSTimeInterval   const SECONDS_PER_HOUR;
//extern NSTimeInterval   const SECONDS_PER_DAY;
//extern NSTimeInterval   const SECONDS_PER_WEEK;
//extern NSTimeInterval   const SECONDS_PER_MONTH;

@interface MGTask : NSObject




#pragma mark - public properties
//TODO: It may be worth considering storing date components instead of dates and then processing them to get components, more memory but less processing time for each task
//TODO: Might be worth
@property (nonatomic)           NSUInteger  uID;
@property (strong, nonatomic)   NSString    *name;
@property (strong, nonatomic)   NSDate      *dateCreated;
@property (strong, nonatomic)   NSDate      *dateModified;
@property (strong, nonatomic)   NSDate      *dateDue;
@property (nonatomic)           BOOL        isComplete;

-(instancetype)initWithName:(NSString *)name uID:(NSUInteger)uID dateDue:(NSDate *)dateDue;
-(instancetype)init;

-(NSString *)description;

-(NSDictionary *)dictionaryFromTask;

-(NSString *)completeDueDateString;


@end

//
//  DMTask.h
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGTask : NSObject

#pragma mark - public properties
//TODO: It may be worth considering storing date components instead of dates and then processing them to get components, more memory but less processing time for each task
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


@end

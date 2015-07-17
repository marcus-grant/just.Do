//
//  DMTask.m
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "MGTask.h"

@implementation MGTask

-(instancetype)initWithName:(NSString *)name uID:(NSUInteger)uID dateDue:(NSDate *)dateDue
{
    self = [super init];
    if (self)
    {
        _name           = name;
        _uID            = uID;
        _dateDue        = dateDue;
        _dateCreated    = [[NSDate alloc]init];
        _dateModified   = [[NSDate alloc]init];
        _isComplete     = NO;
        
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //TODO: document epoch seconds from NSDate
        _name           = @"";
        _uID            = 0;
        _dateDue        = nil;
        _dateCreated    = [[NSDate alloc]init];
        _dateModified   = [[NSDate alloc]init];
        _isComplete     = NO;
        
    }
    return self;
}
//TODO: Implement MGTask init with dictionary as input
-(instancetype)initWithDictionary:(NSDictionary *)taskDictionary
{
//    self = [super init];
//    if (self)
//    {
//        _uID            = (NSUInteger)taskDictionary[@"uID"];
//        _name           = taskDictionary[@"name"];
//        _dateDue        = taskDictionary[@"dateDue"];
//        _dateCreated    = taskDictionary[@"dateCreated"];
//        _dateModified   = taskDictionary[@"dateModified"];
//        if (taskDictionary[@"isComplete"])
//            _isComplete = YES;
//        
//        
//    }
    return self;
}

//TODO: reduce variable and copy use so its all inline
-(NSString *)description
{
    NSMutableString *outputString = [[NSMutableString alloc]initWithFormat: @"Task #"];
    [outputString appendFormat:@"%lu\nname:%@\nDate Created:%@ Date Modified:%@ Date Due:%@",
     self.uID, self.name, self.dateCreated, self.dateModified, self.dateDue];
    return outputString;
}
//TODO: Evaluate best way to convert the tasks properties into a dictionary
-(NSDictionary *)dictionaryFromTask
{
    return @{};
}


@end

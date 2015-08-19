//
//  DMTask.m
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "MGTask.h"

//NSTimeInterval  const SECONDS_PER_HOUR = 3600.0;   /* 60s x 1hr */
//NSTimeInterval  const SECONDS_PER_DAY  = 86400.0;  /* 3600 * 24 */
//NSTimeInterval  const SECONDS_PER_WEEK = 604800.0; /* 86400 * 7 */
//NSTimeInterval  const SECONDS_PER_MONTH = 2628000.0;/*365d/yr * 86400s/d / 12mo/yr*/


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

#pragma mark - date methods

-(NSString *)completeDueDateString
{
    NSMutableString *returnString;
    returnString = [[NSMutableString alloc]initWithString:[self dateStringFromDate:self.dateDue]];
    [returnString appendString:[self.dateDue shortTimeStringWithMilitaryTime:YES]];
    return returnString;
}


//returns date string ONLY from date, no time
//If it is today, it returns "Today", or "Tomorrow" if thats the case
//If the date is within a week and not today or tomorrow then the day of the week is returned ("Monday","Saturday",etc)
//else the date is simply mm/dd
-(NSString *)dateStringFromDate:(NSDate *)inputDate
{
    //if input date is today then date string should be "Today"
    if ([inputDate isToday])
    {
        return @"Today";
    }
    //if input date is today then the date string should be "Tomorrow"
    else if ([inputDate isTomorrow])
    {
        return @"Tomorrow";
    }
    //if input date is within a week of now but not today or tomorrow
    //make the string monday, friday, etc.
    else if ([inputDate isBefore:[NSDate nextWeek]])
    {
        return [inputDate dayOfWeekString];
    }
    //otherwise just show the date
    else
    {
        return [inputDate shortDateOnlyStringWithLocale:@"en_us"];
    }
}

@end

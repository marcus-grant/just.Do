//
//  NSDate+MGMethods.m
//  just.do
//
//  Created by Marcus Grant on 8/3/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "NSDate+MGMethods.h"

static const unsigned yrMoDayCompFlags = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay);
static const unsigned completeCompFlags = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond);

@implementation NSDate (MGMethods)


#pragma mark - Calendar and TimeZone Stuff


// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
// Used to alleviate bottlenecks? Look into this
+ (NSCalendar *)currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}



#pragma mark - Relative Dates

+(NSDate *)now
{
    return [NSDate date];
}
+(NSDate *)tomorrow
{
    return [[NSDate now] dateByAddingDays:SECONDS_PER_DAY];
}

+(NSDate *)yesterday
{
    return [[NSDate now] dateByAddingTimeInterval:-1*SECONDS_PER_DAY];
}

+(NSDate *)nextWeek
{
    return [[NSDate now] dateByAddingTimeInterval:SECONDS_PER_WEEK];
}

#pragma mark - Date Comparisons

-(BOOL)isSameDateAs:(NSDate *)inputDate
{
    NSDateComponents *selfComponents = [[NSCalendar currentCalendar] components:yrMoDayCompFlags
                                                                       fromDate:self];
    NSDateComponents *inputComponents = [[NSCalendar currentCalendar] components:yrMoDayCompFlags
                                                                        fromDate:inputDate];
    return ((selfComponents.year == inputComponents.year) &&
            (selfComponents.month == inputComponents.month) &&
            (selfComponents.day == inputComponents.day));
}

-(BOOL)isToday
{
    return [self isSameDateAs:[NSDate now]];
}

-(BOOL)isYesterday
{
    return [self isSameDateAs:[NSDate yesterday]];
}

-(BOOL)isTomorrow
{
    return [self isSameDateAs:[NSDate tomorrow]];
}

-(BOOL)isAfter:(NSDate *)inputDate
{
    NSTimeInterval secondsFromOriginToInputDate = [inputDate timeIntervalSinceReferenceDate];
    NSTimeInterval secondsFromOriginToSelf = [self timeIntervalSinceReferenceDate];
    return secondsFromOriginToSelf > secondsFromOriginToInputDate;
}

-(BOOL)isBefore:(NSDate *)inputDate
{
    NSTimeInterval secondsFromOriginToInputDate = [inputDate timeIntervalSinceReferenceDate];
    NSTimeInterval secondsFromOriginToSelf = [self timeIntervalSinceReferenceDate];
    return secondsFromOriginToSelf < secondsFromOriginToInputDate;
}


#pragma mark - Dates By Adding

-(NSDate *)dateByAddingYear:(NSInteger)inputYears
                      month:(NSInteger)inputMonths
                        day:(NSInteger)inputDays
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    //set only date component (day) to be inputDays
    [components setDay:inputYears];
    [components setDay:inputMonths];
    [components setDay:inputDays];
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                                       toDate:self
                                                                      options:0];
    return returnDate;
    
}

-(NSDate *)dateByAddingDays:(NSInteger)inputDays
{
    return [self dateByAddingTimeInterval:SECONDS_PER_DAY];
}

#pragma mark - Component Getters
-(NSUInteger)year
{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitYear fromDate:self];
}
-(NSUInteger)month
{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitMonth fromDate:self];
}
-(NSUInteger)day
{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitDay fromDate:self];
}
-(NSUInteger)hour24
{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitHour fromDate:self];
}
-(NSUInteger)hour12
{
    NSUInteger militaryHour = [self hour24];
    if (militaryHour==12 || militaryHour==0)
    {
        return 12;
    }
    else if (militaryHour >= 13)
    {
        return militaryHour-12;
    }
    else
    {
        return militaryHour;
    }
}

-(BOOL)isPM
{
    return [self hour24] >= 12;
}

-(NSUInteger)minute
{
    return [[NSCalendar currentCalendar]component:NSCalendarUnitMinute fromDate:self];
}

-(NSUInteger)second
{
    return [[NSCalendar currentCalendar]component:<#(NSCalendarUnit)#> fromDate:<#(NSDate *)#>]
}



#pragma mark - String Methods

-(NSString *)dayOfWeekString
{
    NSString *dayOfWeek;
    NSUInteger weekday = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:[NSDate now]];
    switch (weekday)
    {
        case 1:
            dayOfWeek = @"Sunday";
            break;
        case 2:
            dayOfWeek = @"Monday";
            break;
        case 3:
            dayOfWeek = @"Tuesday";
            break;
        case 4:
            dayOfWeek = @"Wednesday";
            break;
        case 5:
            dayOfWeek = @"Thursday";
            break;
        case 6:
            dayOfWeek = @"Friday";
            break;
        case 7:
            dayOfWeek = @"Saturday";
            break;
        default:
            break;
    }
    return dayOfWeek;
    
}
//returns date in format: "mm/dd" for us_en
-(NSString *)shortDateOnlyStringWithLocale:(NSString *)localeString
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:completeCompFlags fromDate:self];
    NSUInteger month = [components month];
    NSUInteger day = [components day];
    if ([[localeString uppercaseString] isEqualToString:@"EN_US"]);
    {
        return [NSString stringWithFormat:@"%lu/%lu",month,day];
    }
    return nil;
}

-(NSString *)shortTimeStringWithMilitaryTime:(BOOL)militaryTime
{
    if (militaryTime)
    {
        return [NSString stringWithFormat:@"%lu:%lu",[self hour24],[self minute]];
    }
    else
    {
        if ([self hour24]>=12)
        {
            return [NSString stringWithFormat:@"%lu:%lup",[self hour12],[self minute]];
        }
        else
        {
            return [NSString stringWithFormat:@"%lu:%lua",[self hour12],[self minute]];
        }
    }
}

@end

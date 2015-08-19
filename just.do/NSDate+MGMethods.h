//
//  NSDate+MGMethods.h
//  just.do
//
//  Created by Marcus Grant on 8/3/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - seconds to time unit constants
#define SECONDS_PER_MINUTE      60
#define SECONDS_PER_HOUR		3600
#define SECONDS_PER_DAY         86400
#define SECONDS_PER_WEEK		604800
#define SECONDS_PER_FEBRUARY    2419200
#define SECONDS_PER_30MONTH     2592000
#define SECONDS_PER_31MONTH     2678400
#define SECONDS_PER_YEAR		31536000/*365*24*3600*/

@interface NSDate (MGMethods)

#pragma mark - Calendar and TimeZone Stuff

+(NSCalendar *)currentCalendar;

#pragma mark - Relative Dates

+(NSDate *)now;
+(NSDate *)tomorrow;
+(NSDate *)yesterday;
+(NSDate *)nextWeek;

#pragma mark - Date Comparisons

-(BOOL)isSameDateAs:(NSDate *)inputDate;
-(BOOL)isToday;
-(BOOL)isYesterday;
-(BOOL)isTomorrow;
-(BOOL)isAfter:(NSDate *)inputDate;
-(BOOL)isBefore:(NSDate *)inputDate;

#pragma mark - Dates By Adding

-(NSDate *)dateByAddingYear:(NSInteger)inputYears
                      month:(NSInteger)inputMonths
                        day:(NSInteger)inputDays;

-(NSDate *)dateByAddingDays:(NSInteger)inputDays;

#pragma mark - Component Getters
-(NSUInteger)year;
-(NSUInteger)month;
-(NSUInteger)day;
-(NSUInteger)hour24;
-(NSUInteger)hour12;
-(BOOL)isPM;
-(NSUInteger)minute;
-(NSUInteger)second;



#pragma mark - String Methods

-(NSString *)dayOfWeekString;
-(NSString *)shortDateOnlyStringWithLocale:(NSString *)localeString;
-(NSString *)shortTimeStringWithMilitaryTime:(BOOL)militaryTime;

@end

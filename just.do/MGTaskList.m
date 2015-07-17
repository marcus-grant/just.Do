//
//  MGDoList.m
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "MGTaskList.h"

@implementation MGTaskList

-(instancetype)initForTesting
{
    self = [super init];
    if(self)
    {
        _name   = @"Inbox";
        //setup the testing tasks
        NSArray *testingTaskNames = @[ @"Do laundry", @"Prepare dinner", @"Call Mom", @"Get mail",
                                       @"Get dentist appointment", @"buy groceries", @"Read articles",
                                       @"Fix sink", @"Pay bills", @"Shop for flight tickets",
                                       @"Disk maintenance", @"Go to gym", @"Sort Closet", @"Charge phone"];
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < testingTaskNames.count; i++)
        {
            MGTask *task = [[MGTask alloc]initWithName:testingTaskNames[i]
                                                   uID:i+1
                                               dateDue:[NSDate dateWithTimeIntervalSinceNow:40000*i]];
            [tempArray addObject:task];
        }
        _tasks = tempArray;
    }
    return self;
}

@end

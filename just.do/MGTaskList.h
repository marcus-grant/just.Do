//
//  MGDoList.h
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGTask.h"

@interface MGTaskList : NSObject

@property (strong, nonatomic)   NSString    *name;
@property (strong, nonatomic)   NSArray     *tasks;

//TODO: implement the below properties
//@property (strong, nonatomic)   NSString    *description;
//@property (strong, nonatomic)   NSDate      *dateCreated;
//@property (strong, nonatomic)   NSDate      *dateModified;

-(instancetype)initForTesting;


@end

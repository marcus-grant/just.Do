//
//  AppDelegate.m
//  just.do
//
//  Created by Marcus Grant on 6/26/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDate+MGMethods.h"
#import "MGCoreDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self runTests];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MGTaskListViewController *tableViewController = [[MGTaskListViewController alloc] initWithStyle:UITableViewCellStyleValue1];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [self.window setRootViewController:navigationController];
    
    
    //TODO: figure out these mechanics for version detection and document it
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        //bright orange color
        UIColor *brightOrange = [UIColor colorWithRed:246.0/255.0
                                                green:138.0/255.0
                                                 blue:87.0/255.0
                                                alpha:1];

        
        // iOS 7.0 or later
        navigationController.navigationBar.barTintColor = brightOrange;
        navigationController.navigationBar.translucent = NO;
    }
    else
    {
        // iOS 6.1 or earlier
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:246.0/255.0
                                                                       green:138.0/255.0
                                                                        blue:87.0/255.0
                                                                       alpha:1];
    }
    
    [tableViewController setTitle:@"Inbox"];

    
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    

    
//      Playing with time and date objects
//    NSLocale *usLocale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//    NSLocale *isoLocale = [[NSLocale alloc]initWithLocaleIdentifier:@"iso_std"];
//    NSDateFormatter *usDateFormatter = [[NSDateFormatter alloc]init];
//    NSDateFormatter *isoDateFormatter = [[NSDateFormatter alloc]init];
//    [usDateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
//    [isoDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//
//    NSTimeInterval secondsPerDay    = 60 * 60 * 24;
//    NSDate *now, *tomorrow, *yesterday, *nextWeek;
//    now         = [[NSDate alloc]init];
//    tomorrow    = [now dateByAddingTimeInterval:secondsPerDay];
//    yesterday   = [now dateByAddingTimeInterval:-secondsPerDay];
//    nextWeek    = [now dateByAddingTimeInterval:secondsPerDay*7];
//    NSTimeInterval secondsSinceRef = [NSDate timeIntervalSinceReferenceDate];
//    //NSString *nowUSFormat = [NSDateFormatter localizedStringFromDate:now
//
//    NSLog(@"The number of seconds since Jan 1st 2001 is %f.2",secondsSinceRef);
//    NSLog(@"The date description for current time: %@",[now description]);
//    
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setWeekday:2]; // Monday
//    [components setWeekdayOrdinal:1]; // The first Monday in the month
//    [components setMonth:8]; // May
//    [components setYear:2015];
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *date = [gregorian dateFromComponents:components];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//TODO: Cleanup Delegate Tests
-(void)runTests
{
    
    //Core Data Manager Tests
    MGCoreDataManager *dataManager = [MGCoreDataManager sharedInstance];
    NSManagedObjectContext *context = [dataManager managedObjectContext];
    
    
    
//    NSDate *today = [NSDate now];
//    NSDate *tomorrow = [NSDate tomorrow];
//    NSDate *yesterday = [NSDate yesterday];
//    NSLog(@"today is:%@",today);
//    NSLog(@"tomorrow is:%@",tomorrow);
//    NSLog(@"yesterday was:%@",yesterday);
//    NSDate *todayWithAlittle = [today dateByAddingTimeInterval:3600.0];
//    BOOL isItTomorrow = [[todayWithAlittle dateByAddingDays:1] isTomorrow];
//    NSLog(@"today+1hr isTomorrow = %@",isItTomorrow ? @"YES" : @"NO");
//    NSLog(@"today is %@ before yesterday", [today isBefore:yesterday] ? @"" : @"not");
//    NSLog(@"Today is: %@",[today dayOfWeekString]);
//    NSLog(@"Today is (short date): %@",[today shortDateOnlyStringWithLocale:@"en_us"]);
//    NSLog(@"The time is (short time): %@",[today shortTimeStringWithMilitaryTime:NO]);
    
}


@end

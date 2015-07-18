//
//  MCTableViewController.m
//  MCSwipeTableViewCell
//
//  Created by Ali Karagoz on 24/02/13.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "TaskListViewController.h"

static NSUInteger const kMCNumItems = 7;

@interface TaskListViewControlelr () //<MCSwipeTableViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) NSUInteger nbItems;
@property (nonatomic, strong) MCSwipeTableViewCell *cellToDelete;

@end

@implementation MCTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _nbItems = kMCNumItems;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Swipe Table View";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _nbItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *checkView = [self viewWithImageName:@"check_icon"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    UIView *crossView = [self viewWithImageName:@"garbage_bin_icon"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    
    UIView *clockView = [self viewWithImageName:@"clock_icon"];
    UIColor *yellowColor = [UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0];
    
    UIView *listView = [self viewWithImageName:@"menu_icon"];
    UIColor *brownColor = [UIColor colorWithRed:206.0 / 255.0 green:149.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    if (indexPath.row % kMCNumItems == 0) {
        [cell.textLabel setText:@"Switch Mode Cell"];
        [cell.detailTextLabel setText:@"Swipe to switch"];
        
        [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Checkmark\" cell");
        }];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
        }];
        
        [cell setSwipeGestureWithView:clockView color:yellowColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Clock\" cell");
        }];
        
        [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"List\" cell");
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 1) {
        [cell.textLabel setText:@"Exit Mode Cell"];
        [cell.detailTextLabel setText:@"Swipe to delete"];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            [self deleteCell:cell];
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 2) {
        [cell.textLabel setText:@"Mixed Mode Cell"];
        [cell.detailTextLabel setText:@"Swipe to switch or delete"];
        cell.shouldAnimateIcons = YES;
        
        [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Checkmark\" cell");
        }];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            [self deleteCell:cell];
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 3) {
        [cell.textLabel setText:@"Un-animated Icons"];
        [cell.detailTextLabel setText:@"Swipe"];
        cell.shouldAnimateIcons = NO;
        
        [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Checkmark\" cell");
        }];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            [self deleteCell:cell];
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 4) {
        [cell.textLabel setText:@"Right swipe only"];
        [cell.detailTextLabel setText:@"Swipe"];
        
        [cell setSwipeGestureWithView:clockView color:yellowColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Clock\" cell");
        }];
        
        [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"List\" cell");
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 5) {
        [cell.textLabel setText:@"Small triggers"];
        [cell.detailTextLabel setText:@"Using 10% and 50%"];
        cell.firstTrigger = 0.1;
        cell.secondTrigger = 0.5;
        
        [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Checkmark\" cell");
        }];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            [self deleteCell:cell];
        }];
    }
    
    else if (indexPath.row % kMCNumItems == 6) {
        [cell.textLabel setText:@"Exit Mode Cell + Confirmation"];
        [cell.detailTextLabel setText:@"Swipe to delete"];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            _cellToDelete = cell;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete?"
                                                                message:@"Are you sure your want to delete the cell?"
                                                               delegate:self
                                                      cancelButtonTitle:@"No"
                                                      otherButtonTitles:@"Yes", nil];
            [alertView show];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MCTableViewController *tableViewController = [[MCTableViewController alloc] init];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

#pragma mark - MCSwipeTableViewCellDelegate


// When the user starts swiping the cell this method is called
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did start swiping the cell!");
}

// When the user ends swiping the cell this method is called
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did end swiping the cell!");
}

// When the user is dragging, this method is called and return the dragged percentage from the border
- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage {
    // NSLog(@"Did swipe with percentage : %f", percentage);
}

#pragma mark - Utils

- (void)reload:(id)sender {
    _nbItems = kMCNumItems;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    _nbItems--;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // No
    if (buttonIndex == 0) {
        [_cellToDelete swipeToOriginWithCompletion:^{
            NSLog(@"Swiped back");
        }];
        _cellToDelete = nil;
    }
    
    // Yes
    else {
        _nbItems--;
        [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:_cellToDelete]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end



////////////////////////////////////////////
////
////  DoListViewController.m
////  just.do
////
////  Created by Marcus Grant on 7/15/15.
////  Copyright (c) 2015 Marcus Grant. All rights reserved.
////
//
//#import "TaskListViewController.h"
//
////static CGFloat const SWIPE_TRIGGER1_RATIO       = 0.25; // % limit to trigger first action
////static CGFloat const SWIPE_TRIGGER2_RATIO       = 0.75; // % limit to trigger second action
////static CGFloat const SWIPE_BOUNCE_AMPLITURE     = 20.0; // Max bounce when releasing swipe
////static CGFloat const SWIPE_DAMPING              = 0.6;  // Damping to release animation
////static CGFloat const SWIPE_VELOCITY             = 0.9;  // Velocity of release animation
////static CGFloat const SWIPE_ANIMATION_TIME       = 0.4;  // Duration of release animation (s)
////static NSTimeInterval const SWIPE_BOUNCE_TIME1  = 0.2;  // Duration of 1st pt of bounce anim
////static NSTimeInterval const SWIPE_BOUNCE_TIME2  = 0.1;  // Duration of 2nd pt of bounce anim
////static NSTimeInterval const SWIPE_TIME_MAX      = 0.25; // Highest duraton possible for swiping
////static NSTimeInterval const SWIPE_TIME_MIN      = 0.1;  // Lowest duration for swipe animation
//
////typedef ES_ENUM(NSUInteger, MCSwipeTableViewCellDirection)
////{
////    MCSwipeTableViewCellDirectionLeft = 0,
////    MCSwipeTableViewCellDirectionLeftCenter,
////    MCSwipeTableViewCellDirectionRight
////    
////};
//
//@interface TaskListViewController ()
////TODO: Get rid of tester objects when done
//@property (strong, nonatomic)   MGTaskList    *testList;
//
//@end
//
//@implementation TaskListViewController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    
//    self.testList = [[MGTaskList alloc]initForTesting];
//    
//    
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return self.testList.tasks.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //We will want a static string identifier for our cell to ease the cell setup process
//    static NSString *cellIdentifier = @"taskCell";
//    
//    //create the swipe-able cell
//    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (!cell)
//    {
//        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:cellIdentifier];
//        
//        //remove inset of iOS7 seperators
//        //TODO: document 'selector'
//        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
//        {
//            cell.separatorInset = UIEdgeInsetsZero;
//        }
//        //TODO: play around with this value to check out what style it means and document it
//        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//        
//        // Set the background color of the cell
//        //TODO: Maybe use font awesome pod instead?
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        
//    }
//    
//    //set the default inactive cell swipe state color to be tableView background
//    //[cell setDefaultColor:self.tableView.backgroundColor];
//    
//    NSString *taskName = self.testList.tasks[indexPath.row];
//    [cell.textLabel setText:taskName];
//    
//    //configure the swipe views and their colors
//    UIView  *checkSwipeView = [self viewWithImageName:@"check_icon"];
//    UIColor *checkViewColor = [self colorWithIntRed:85
//                                              green:213
//                                               blue:80
//                                      andFloatAlpha:1.0];
//    UIView  *deleteSwipeView = [self viewWithImageName:@"garbage_bin_icon"];
//    UIColor *deleteViewColor = [self colorWithIntRed:232
//                                              green:61
//                                               blue:14
//                                      andFloatAlpha:1.0];
//    UIView  *snoozeSwipeView = [self viewWithImageName:@"check_icon"];
//    UIColor *snoozeViewColor = [self colorWithIntRed:254
//                                              green:217
//                                               blue:56
//                                      andFloatAlpha:1.0];
//    UIView  *menuSwipeView = [self viewWithImageName:@"check_icon"];
//    UIColor *menuViewColor = [self colorWithIntRed:206
//                                              green:149
//                                               blue:98
//                                      andFloatAlpha:1.0];
//    
//    //add gestures for each swipe state to go with each swipe view type
//    [cell setSwipeGestureWithView:checkSwipeView
//                            color:checkViewColor
//                             mode:MCSwipeTableViewCellModeSwitch
//                            state:MCSwipeTableViewCellState1
//                  completionBlock:^(MCSwipeTableViewCell *cell,
//                                    MCSwipeTableViewCellState state,
//                                    MCSwipeTableViewCellMode mode)
//    {
//        NSLog(@"Did swipe to \"check\" state");
//        //TODO: do check-state stuff
//    }];
//    [cell setSwipeGestureWithView:deleteSwipeView
//                            color:deleteViewColor
//                             mode:MCSwipeTableViewCellModeSwitch
//                            state:MCSwipeTableViewCellState2
//                  completionBlock:^(MCSwipeTableViewCell *cell,
//                                    MCSwipeTableViewCellState state,
//                                    MCSwipeTableViewCellMode mode)
//     {
//         NSLog(@"Did swipe to \"delete\" state");
//         //TODO: do delete-state stuff
//     }];
//    [cell setSwipeGestureWithView:snoozeSwipeView
//                            color:snoozeViewColor
//                             mode:MCSwipeTableViewCellModeSwitch
//                            state:MCSwipeTableViewCellState3
//                  completionBlock:^(MCSwipeTableViewCell *cell,
//                                    MCSwipeTableViewCellState state,
//                                    MCSwipeTableViewCellMode mode)
//     {
//         NSLog(@"Did swipe to \"snooze\" state");
//         //TODO: do snooze-state stuff
//     }];
//    [cell setSwipeGestureWithView:menuSwipeView
//                            color:menuViewColor
//                             mode:MCSwipeTableViewCellModeSwitch
//                            state:MCSwipeTableViewCellState4
//                  completionBlock:^(MCSwipeTableViewCell *cell,
//                                    MCSwipeTableViewCellState state,
//                                    MCSwipeTableViewCellMode mode)
//     {
//         NSLog(@"Did swipe to \"menu\" state");
//         //TODO: do menu-state stuff
//     }];
//    
//    
//    
//    return cell;
//}
//
//# pragma mark - helper methods
//
////since the swipe cell needs to embedd views and we want icons embedded within the swipe cell view this helper method returns a UIVIew with the appropriate UIImageView
//- (UIView *)viewWithImageName:(NSString *)imageName
//{
//    UIImage *image = [UIImage imageNamed:imageName];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.contentMode = UIViewContentModeCenter;
//    return imageView;
//}
//- (UIColor *)colorWithIntRed:(NSInteger)red
//                        green:(NSInteger)green
//                         blue:(NSInteger)blue
//              andFloatAlpha:(CGFloat)alpha
//{
//    return [UIColor colorWithRed:red/255.0
//                           green:green/255.0
//                            blue:blue/255.0
//                           alpha:alpha];
//}
//                           
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end

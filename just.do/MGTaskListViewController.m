//
//  DoListViewController.m
//  just.do
//
//  Created by Marcus Grant on 7/15/15.
//  Copyright (c) 2015 Marcus Grant. All rights reserved.
//

#import "MGTaskListViewController.h"

@interface MGTaskListViewController () <MCSwipeTableViewCellDelegate,
                                        UIAlertViewDelegate,
                                        UITableViewDelegate,
                                        UITableViewDataSource>
//TODO: Get rid of tester objects when done
@property (strong, nonatomic)   MGTaskList*         testList;
@property (nonatomic)           NSUInteger          taskCount;
@property (strong, nonatomic)   MCSwipeTableViewCell* cellToDelete;
@property (strong, nonatomic)   UITextField*        taskNameTextField;
@property (strong, nonatomic)   UIColor*            navBarColor;
@property (strong, nonatomic)   UIAlertController*  alertController;


@end

@implementation MGTaskListViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self)
    {
        //_testList     = [[MGTaskList alloc]initForTesting];
        _taskCount      = self.testList.tasks.count;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Task Inbox";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];
    
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.testList.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"When does cellforRowget called");
    
    //cell.detailTextLabel.text = currentTask.dateDue;
    
    static NSString *CellIdentifier = @"taskCell";
    
    
    
    MCSwipeTableViewCell *cell = (MCSwipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:CellIdentifier];
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    MGTask *currentTask = self.testList.tasks[indexPath.row];
    
    cell.firstTrigger = 0.1;
    cell.secondTrigger = 0.6;
    cell.textLabel.text = currentTask.name;
    
    return cell;
}

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIView *swipeToCompleteView = [self viewWithImageName:@"check"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    UIView *swipeToSnoozeView = [self viewWithImageName:@"clock"];
    UIColor *yellowColor = [UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0];
    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
        
    [cell setSwipeGestureWithView:swipeToCompleteView
                            color:greenColor
                             mode:MCSwipeTableViewCellModeSwitch
                            state:MCSwipeTableViewCellState1
                  completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode)
    {
        
        [self grayAndStrikethroughCell:cell];
        
        //[self tableView:self moveRowAtIndexPath:indexPath.row toIndexPath:[NSIndexPath indexPathWithIndex:self.ta]];
         NSLog(@"Did swipe \"Checkmark\" cell");
    }];

    
    [cell setSwipeGestureWithView:swipeToSnoozeView
                            color:yellowColor
                             mode:MCSwipeTableViewCellModeSwitch
                            state:MCSwipeTableViewCellState3
                  completionBlock:^(
                                    MCSwipeTableViewCell *cell,
                                    MCSwipeTableViewCellState state,
                                    MCSwipeTableViewCellMode mode
                                    )
    {/*snooze view trigger block*/
        
        NSLog(@"Did swipe \"Clock\" cell");
        
        //alert controller stuff
        self.alertController = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Snooze the task!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *snoozeTillTonight = [UIAlertAction actionWithTitle:@"Tonight"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action)
                                            {
                                                //set the time for the
                                            }];
        UIAlertAction *snoozeTillTomorrow = [UIAlertAction actionWithTitle:@"Tomorrow"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action)
                                             {
                                                 //set the time for the
                                             }];
        UIAlertAction *snoozeTillNextWeek = [UIAlertAction actionWithTitle:@"Next Week"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action)
                                             {
                                                 //set the time for the
                                             }];
        [self.alertController addAction:snoozeTillTonight];
        [self.alertController addAction:snoozeTillTomorrow];
        [self.alertController addAction:snoozeTillNextWeek];
        
        [self presentViewController:self.alertController animated:YES completion:^{
            NSLog(@"Presenting Alert View Controller");
        }];
    }];
    
//    [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
//        NSLog(@"Did swipe \"List\" cell");
//    }];
}



#pragma mark - UIAlertViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: Make Detail View Controller and push it into view
    //MGTaskDetailViewController *detailVC = [[MGTaskDetailViewController alloc] init];
    //[self.navigationController pushViewController:detailVC animated:YES];
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

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"string entered=%@",self.taskNameTextField.text);
}

- (void)addButtonTapped:(id)sender
{
    //TODO: do add button stuff
    
    
}


- (void)reloadButtonTapped:(id)sender {
    _testList = [[MGTaskList alloc]initForTesting];
    _taskCount = self.testList.tasks.count;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

//TODO: WHY DOES deleteRowsAtIndexPaths: HATE ME!?!?!?!?!?!?!
- (void)deleteCell:(MCSwipeTableViewCell *)cell
{
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    if (!cell ) {
        
        NSLog(@"Cell isn't set!");
    }
    
    //WTF IS THIS?!?!?
    //NSParameterAssert(cell);
    
    self.taskCount--;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    
    NSLog(@"What is the index path: %@", indexPath);
    

    
    NSMutableArray *copy = [self.testList.tasks mutableCopy];
    [copy removeObjectAtIndex:indexPath.row];
    
    self.testList.tasks = [copy copy];
    
    
    
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    
    

    
    
    
   //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
   
    
}
//TODO: methods to move complete tasks and move them to a completed list
//-(void)moveTaskInCell:(MCSwipeTableViewCell *)cell toList:
//
//-(void)completeTaskWithin:(MCSwipeTableViewCell *)taskCell
//                andSendToList:(MGTaskList *)completedTaskList
//{
//    //TODO:refactor testList
//    //TODO:subcalss MGTaskList so that it has its own removal functions
//    return nil;
//    
//}

-(void)grayAndStrikethroughCell:(MCSwipeTableViewCell *)cell
{
    UIColor *grayColor = [UIColor lightGrayColor];
    NSDictionary *strikeAttrbt = @{ NSStrikethroughStyleAttributeName   :
                                        @(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName      :
                                        grayColor};
    
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:cell.textLabel.text
                                                                    attributes:strikeAttrbt];
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

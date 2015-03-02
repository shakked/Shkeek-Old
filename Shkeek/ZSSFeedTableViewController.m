//
//  ZSSFeedTableViewController.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/27/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSFeedTableViewController.h"
#import "ZSSFeedCell.h"
#import "DateTools.h"

@interface ZSSFeedTableViewController ()

@property (nonatomic, strong) NSArray *updates;

@end

@implementation ZSSFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    
    _updates = @[@{@"groupImage" : [UIImage imageNamed:@"Table-50.png"],
                   @"update" : @"It looks like we won't be having practice tonight. Please report to us if you would still like to come",
                   @"date" : [NSDate date]},
                 @{@"groupImage" : [UIImage imageNamed:@"Home-50.png"],
                   @"update" : @"Just kidding, practice has been rescheduled. Please report for action to the soccer fields at 3:30pm and notify me if you have any questions.",
                   @"date" : [NSDate dateWithTimeIntervalSinceNow:NSTimeIntervalSince1970]},
                 @{@"groupImage" : [UIImage imageNamed:@"About-50.png"],
                   @"update" : @"Don't know what I was talking about. Class has been cancelled. Do not come to practice, I repeat do not come to practice.",
                   @"date" : [NSDate dateWithTimeIntervalSinceNow:30.0]}
                 ];
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"ZSSFeedCell" bundle:nil] forCellReuseIdentifier:@"ZSSFeedCell"];
    self.tableView.estimatedRowHeight = 90.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(pullToResfreshActivated)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pullToResfreshActivated {
    [NSThread sleepForTimeInterval:2.0f];

    
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.updates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZSSFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZSSFeedCell" forIndexPath:indexPath];
    NSDictionary *update = self.updates[indexPath.row];
    
    cell.updateLabel.text = update[@"update"];
    cell.groupImageView.image = [UIImage imageNamed:@"Table-50.png"];
    
    NSDate *timeOfUpdate = update[@"date"];
    cell.timeLabel.text = timeOfUpdate.shortTimeAgoSinceNow;
    
    return cell;
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

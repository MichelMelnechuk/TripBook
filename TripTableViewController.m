//
//  TripTableViewController.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "TripTableViewController.h"
#import "TripTableViewCell.h"
#import "ParseWrapper.h"
#import "Trip.h"

@interface TripTableViewController ()

@end

@implementation TripTableViewController
{
    
    NSMutableArray *arrayOfTrips;
    NSMutableArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayOfTrips = [[NSMutableArray alloc]initWithArray:[[ParseWrapper sharedInstance]getTrips]];
    searchResults = [[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISegmentControl
- (IBAction)handleSegmentControl:(UISegmentedControl *)sender
{
        switch ([sender selectedSegmentIndex]) {
            case 0:
                [self displayNowTrips];
                break;
            case 1:
                [self displayFutureTrips];
                break;
            default:
                break;
        }
}

-(void)displayFutureTrips
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|
                               NSCalendarUnitYear|
                               NSCalendarUnitMonth|
                               NSCalendarUnitDay
                                                              fromDate:[NSDate date]];
    for (int i = 0; i < [arrayOfTrips count]; i++) {
        Trip *tempTrip =arrayOfTrips[i];
        if ([tempTrip.beginDate compare:[today date]] == NSOrderedDescending) {
            [tempArray addObject:tempTrip];
        }
    }
    searchResults = tempArray;

}

-(void)displayNowTrips
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|
                               NSCalendarUnitYear|
                               NSCalendarUnitMonth|
                               NSCalendarUnitDay
                                                              fromDate:[NSDate date]];
    for (int i = 0; i < [arrayOfTrips count]; i++) {
        Trip *tempTrip =arrayOfTrips[i];
        if ([tempTrip.beginDate compare:[today date]] == NSOrderedAscending ||
            !([tempTrip.beginDate compare:[today date]] == NSOrderedDescending)) {
            [tempArray addObject:tempTrip];
        }
    }
    searchResults = tempArray;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [arrayOfTrips count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    Trip *trip = [searchResults objectAtIndex:indexPath.row];
    cell.destinationFrom.text = trip.destinationFrom;
    cell.destinationTo.text = trip.destinationTo;
    cell.beginDate.text = [NSDateFormatter localizedStringFromDate:trip.beginDate
                                                         dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterFullStyle];
    cell.endDate.text = [NSDateFormatter localizedStringFromDate:trip.endDate
                                                         dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterFullStyle];

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

//
//  ChangeTripViewController.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "ChangeTripViewController.h"
#import "Trip.h"
#import "ParseWrapper.h"

@interface ChangeTripViewController ()
@property (weak, nonatomic) IBOutlet UITextField *destinationFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationToTextField;
@property (strong,nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (strong,nonatomic) Trip *trip;
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *noCommentButton;



@end

@implementation ChangeTripViewController
{
    NSDate *beginDate;
    NSDate *endDate;
    BOOL hiddecommentTextView;
    NSMutableArray *comments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|
                               NSCalendarUnitYear|
                               NSCalendarUnitMonth|
                               NSCalendarUnitDay
                               fromDate:[NSDate date]];
    [self.datePicker setMinimumDate:[today date]]; //fix it
    self.tripsArray = [[NSMutableArray alloc]init];
    comments = [[NSMutableArray alloc]init];
    hiddecommentTextView = YES;
    [self.commentTextView setHidden:hiddecommentTextView];
    [self.noCommentButton setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doSave:(id)sender {
    _trip = [[Trip alloc]init];
    _trip.destinationFrom = self.destinationFromTextField.text;
    _trip.destinationTo = self.destinationToTextField.text;
    _trip.beginDate = beginDate;
    _trip.endDate = endDate;
    _trip.comments = comments;
    [self.tripsArray addObject:_trip];
    if ([[ParseWrapper sharedInstance]getTrips] == nil) {
        [[ParseWrapper sharedInstance]saveTrips:self.tripsArray];
    } else {
        [[ParseWrapper sharedInstance]refreshDataWithTrips:self.tripsArray];
    }
 
    [self performSegueWithIdentifier:@"saveSegue" sender:self];

    
}
- (IBAction)didChangeValue:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        beginDate = self.datePicker.date;
        [self.datePicker setDate:beginDate];
    } else if (sender.selectedSegmentIndex == 1) {
        endDate = self.datePicker.date;
        [self.datePicker setDate:endDate];
    }
}
- (IBAction)didAddCommentPush:(UIButton *)sender {
        hiddecommentTextView = !hiddecommentTextView;
    [self.noCommentButton setHidden:NO];
    if ([sender.titleLabel.text  isEqual: @"Save comment"]) {
        [comments addObject:self.commentTextView.text];
        [sender setTitle:@"Add comment" forState:UIControlStateNormal];
        [self.commentsTableView reloadData];
            [self.noCommentButton setHidden:YES];
    } else [sender setTitle:@"Save comment" forState:UIControlStateNormal];

    [self.commentTextView setHidden:hiddecommentTextView];

}
- (IBAction)disgardAllChanges:(UIButton*)sender {
    hiddecommentTextView = !hiddecommentTextView;
    self.commentTextView.text = @"I,";
    [self.noCommentButton setHidden:YES];
    [self.commentTextView setHidden:hiddecommentTextView];
    [self.addCommentButton setTitle:@"Add comment" forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.trip.comments count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [self.commentsTableView dequeueReusableCellWithIdentifier:@"comCell" forIndexPath:indexPath];
        cell.textLabel.text = comments[indexPath.row];
        return cell;
}

@end

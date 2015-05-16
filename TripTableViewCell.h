//
//  TripTableViewCell.h
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *destinationFrom;
@property (weak, nonatomic) IBOutlet UILabel *destinationTo;
@property (weak, nonatomic) IBOutlet UILabel *beginDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *countOfDays;



@end

//
//  ChangeTripViewController.h
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeTripViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *tripsArray;


@end

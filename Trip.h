//
//  Trip.h
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property(strong,nonatomic) NSString *destinationTo;
@property(strong,nonatomic) NSString *destinationFrom;
@property(strong,nonatomic) NSDate *beginDate;
@property(strong,nonatomic) NSDate *endDate;
@property(strong,nonatomic) NSMutableArray *comments;

@end

//
//  ParseWrapper.h
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Trip;
@class User;

@interface ParseWrapper : NSObject

+(instancetype)sharedInstance;

-(void)saveUser:(User*)user;
-(User*)getUser;
-(void)saveTrips:(NSMutableArray*)trips;
-(NSMutableArray*)getTrips;
-(void)refreshDataWithTrips:(NSMutableArray*)trips;
-(void)refreshComments:(NSString*)comment inTrip:(Trip*)trip;

@end

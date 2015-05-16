//
//  ParseWrapper.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "ParseWrapper.h"
#import "Trip.h"
#import <Parse/Parse.h>
#import "User.h"

@implementation ParseWrapper

+ (instancetype) sharedInstance
{
    static ParseWrapper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ParseWrapper alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)saveUser:(User*)user
{
    PFObject *savedUser = [PFObject objectWithClassName:@"User"];
    savedUser[@"login"] = user.login;
    savedUser[@"password"] = user.password;
    [savedUser saveInBackground];
}

-(User*) getUser
{
    User *retUser = [[User alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query getObjectInBackgroundWithId:@"user" block:^(PFObject *savedUser, NSError *error) {
        retUser.login = savedUser[@"login"];
        retUser.password = savedUser[@"password"];
    }];
    
    return retUser;
}
-(void)saveTrips:(NSMutableArray*)trips
{
    PFObject *savedTrips = [PFObject objectWithClassName:@"NSMutableArray"];
    savedTrips[@"array"] = trips;
    [savedTrips saveInBackground];

}

-(NSMutableArray*)getTrips
{
    NSMutableArray *retTrips = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"NSMutableArray"];
    [query getObjectInBackgroundWithId:@"array" block:^(PFObject *savesTrips, NSError *error) {
        [retTrips addObjectsFromArray:savesTrips[@"array"]];
        
    }];
    
    return retTrips;
}

-(void)refreshDataWithTrips:(NSMutableArray*)trips{
    PFQuery *query = [PFQuery queryWithClassName:@"NSMutableArray"];
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"array" block:^(PFObject *savesTrips, NSError *error) {
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        savesTrips[@"array"] = trips;
        [savesTrips saveInBackground];
    }];
}

@end

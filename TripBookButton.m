//
//  TripBookButton.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "TripBookButton.h"

@implementation TripBookButton


- (void)drawRect:(CGRect)rect {
    UIBezierPath* path =
    [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width/2];
    [[UIColor lightGrayColor] setFill];
    [path fill];
}


@end

//
//  ScaryBugData.m
//  ScaryBugs
//
//  Created by Brian G. Butterfield on 11/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

@synthesize title = _title;
@synthesize rating = _rating;

- (id)initWithTitle:(NSString *)title rating:(float)rating
{
    if ((self = [super init]))
    {
        self.title = title;
        self.rating = rating;
    }
    
    return self;
}


@end

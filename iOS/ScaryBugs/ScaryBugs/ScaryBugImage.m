//
//  ScaryBugImage.m
//  ScaryBugs
//
//  Created by Brian G. Butterfield on 11/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "ScaryBugImage.h"
#import "ScaryBugData.h"

@implementation ScaryBugImage

@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize image = _fullImage;

- (id)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage
{
    if ((self = [super init]))
    {
        self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.image = fullImage;
    }
    return self;
}


@end

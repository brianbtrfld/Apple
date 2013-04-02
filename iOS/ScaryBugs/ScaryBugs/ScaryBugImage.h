//
//  ScaryBugImage.h
//  ScaryBugs
//
//  Created by Brian G. Butterfield on 11/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugData;

@interface ScaryBugImage : NSObject

@property (strong) ScaryBugData *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *image;

- (id)initWithTitle:(NSString*)title rating:(float)rating
                                     thumbImage:(UIImage*)thumbImage
                                     fullImage:(UIImage*)fullImage;


@end

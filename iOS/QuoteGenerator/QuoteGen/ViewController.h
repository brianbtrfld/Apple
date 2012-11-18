//
//  ViewController.h
//  QuoteGen
//
//  Created by Brian G. Butterfield on 11/16/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//
//  Tutorial:
//  http://www.raywenderlich.com/21320/objectively-speaking-a-crash-course-in-objective-c-ios6
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSMutableArray *movieQuotes;

@property (nonatomic, strong) IBOutlet UITextView *quoteText;
@property (nonatomic, strong) IBOutlet UISegmentedControl *quoteOption;

- (IBAction)quoteButtonTapped:(id)sender;
- (void) useMovieQuote:(NSString*)qouteType;
- (void) useMyQuote;

@end

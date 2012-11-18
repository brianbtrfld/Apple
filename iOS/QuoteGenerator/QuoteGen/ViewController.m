//
//  ViewController.m
//  QuoteGen
//
//  Created by Brian G. Butterfield on 11/16/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.myQuotes = @[@"this is my first quote",
                      @"this is my second quote",
                      @"this is my third quote",
                      @"this is my 4th quote",
                      @"this is my 5th quote",
                      @"this is my 6th quote"];
    
    
    //Load quotes from plist file
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)quoteButtonTapped:(id)sender
{
    if (self.quoteOption.selectedSegmentIndex == 2)
    {
        [self useMyQuote];
    }
    else if (self.quoteOption.selectedSegmentIndex == 0)
    {
        [self useMovieQuote:@"classic"];
    }
    else if (self.quoteOption.selectedSegmentIndex == 1)
    {
        [self useMovieQuote:@"modern"];
    }
    

    
}

- (void) useMyQuote
{
    int arrayCount = [self.myQuotes count];
    
    //display random single quote
    //
    //int index = (arc4random() % arrayCount);
    //NSString *myQuote = self.myQuotes[index];
    //self.quoteText.text = [NSString stringWithFormat:@"Quote:\n\n%@", myQuote];
    
    //display all of the quotes
    NSString *myQuote = nil;
    NSString *myQuotesAll = @"";
    
    for (int i = 0; i < arrayCount; i++)
    {
        myQuote = self.myQuotes[i];
        myQuotesAll = [NSString stringWithFormat:@"%@\n\n\%@", myQuotesAll, myQuote];
    }
    
    self.quoteText.text = [NSString stringWithFormat:@"%@", myQuotesAll];

}

- (void) useMovieQuote:(NSString*)quoteType
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category=%@", quoteType];
    NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
    NSString *displayQuote = nil;
    
    int arrayCount = [filteredArray count];
    
    if (arrayCount > 0)
    {
        int index = (arc4random() % arrayCount);
        
        NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
        
        NSString *quote = filteredArray[index][@"quote"];
        
        if ([source length] != 0)
        {
            displayQuote = [NSString stringWithFormat:@"%@\n\n--%@", quote, source];
        }
        else
        {
            displayQuote = [NSString stringWithFormat:@"%@\n\n--unknown", quote];
        }
        
        if ([quoteType isEqualToString:@"classic"])
        {
            self.quoteText.text = [NSString stringWithFormat:@"Classic Movie Quote:\n\n%@", displayQuote];
        }
        else
        {
            self.quoteText.text = [NSString stringWithFormat:@"Movie Quote:\n\n%@", displayQuote];
        }
        
    }
    else
    {
        self.quoteText.text = [NSString stringWithFormat:@"No quote to display"];
    }
    
    
}

@end

//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Butterfied on 9/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorModel *model;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize model = _model;

- (CalculatorModel *)model
{
    if (!_model)
    {
        _model = [[CalculatorModel alloc] init];
    }
    
    return _model;
}


- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    //NSLog(@"digit pressed = %@", digit);
    
    
    //UILabel *myDisplay = self.display;  // [self display];
    //NSString *currentText = myDisplay.text; //[myDisplay text];
    //NSString *newText = [currentText stringByAppendingString:digit];
    //myDisplay.text = newText; //[myDisplay setText:newText];
    //   above can be written in one line.
    
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    
}

- (IBAction)enterPressed:(UIButton *)sender
{
    [self.model pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        //[self enterPressed];
        [self.model pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
    double result = [self.model performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


@end

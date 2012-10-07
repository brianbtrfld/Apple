//
//  CalculatorModel.m
//  Calculator
//
//  Created by Butterfied on 9/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation CalculatorModel

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil)
    {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)
    {
        [self.operandStack removeLastObject];
    }
    
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation;
{
    double result = 0;
    
    //calculate result
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:@"*"])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"])
    {
        result = [self popOperand] - [self popOperand];
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor != 0)
        {
            result = [self popOperand] / divisor;
        }
        else
        {
            result = 0;
        }
    }
    
    [self pushOperand:result];
    
    return result;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}

@end

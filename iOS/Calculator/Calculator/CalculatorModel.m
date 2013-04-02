//
//  CalculatorModel.m
//  Calculator
//
//  Created by Butterfied on 9/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *programStack;
@end


@implementation CalculatorModel

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil)
    {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (NSString *) descriptionOfProgram:(id)program
{
    return @"implement this later";
}

+ (double) popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    
    if (topOfStack)[stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        
        //calculate result
        if ([operation isEqualToString:@"+"])
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"*"])
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"-"])
        {
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"/"])
        {
            double divisor = [self popOperandOffStack:stack];
            if (divisor != 0)
            {
                result = [self popOperandOffStack:stack] / divisor;
            }
            else
            {
                result = 0;
            }
        }
    }
    
    return result;
}


+ (double) runProgram:(id)program
{
    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"stack = %@", self.programStack];
}

@end

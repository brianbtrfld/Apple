//
//  CalculatorModel.h
//  Calculator
//
//  Created by Butterfied on 9/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (readonly) id program;


+ (double) runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;

@end

//
//  Calculator.m
//  Qalculator
//
//  Created by Juri on 12.04.14.
//  Copyright (c) 2014 Juri Noga. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(double)calulatorWithFirstValue:(double)num1 secondValue:(double)num2 expression:(NSString *)exp calc:(Calculator *)calc{
    double result = 0;
    return result;
}

-(double)addNum:(double)num1 toNum:(double)num2{
    return num1+num2;
}

-(double)subtractFrom:(double)num1 num:(double)num2{
    return num1-num2;
}

-(double)multiplyNum:(double)num1 byNum:(double)num2{
    return num1*num2;
}

-(double)divideNum:(double)num1 byNum:(double)num2{
    return num1/num2;
}

-(double)powerNum:(double)num1 toPower:(double)num2{
    return pow(num1, num2);
}

-(BOOL)checkForPrime:(double)num{
    return YES;
}
@end

//
//  Calculator.m
//  Qalculator
//
//  Created by Juri on 12.04.14.
//  Copyright (c) 2014 Juri Noga. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

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

-(double)calulatorWithFirstValue:(double)num1 secondValue:(double)num2 expression:(NSString *)exp calc:(Calculator *)calc{
    char ex = [exp characterAtIndex:0];
    switch (ex) {
        case '+':
            return [calc addNum:num1 toNum:num2];
            break;
        case '-':
            return [calc subtractFrom:num1 num:num2];
            break;
        case '*':
            return [calc multiplyNum:num1 byNum:num2];
            break;
        case '/':
            if (num2!=0) {
                return [calc divideNum:num1 byNum:num2];
            }
            else{
                return 0;
            }
            break;
        case '^':
            return [calc powerNum:num1 toPower:num2];
            break;
        default:
            return 0;
            break;
    }
}
@end

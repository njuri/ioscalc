//
//  ViewController.m
//  Qalculator
//
//  Created by Juri on 12.04.14.
//  Copyright (c) 2014 Juri Noga. All rights reserved.
//


#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stringerLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *powerButton;
@property (weak, nonatomic) IBOutlet UIButton *multiButton;
@property (weak, nonatomic) IBOutlet UIButton *divButton;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property NSMutableArray *memory;
@property NSMutableArray *input;
@property NSArray *btar;
@property NSString *stringer;
@property double calcRes;
@property BOOL isCalc;
@property BOOL changeUpperLabel;

@end

@implementation ViewController

- (IBAction)buttonNR1:(id)sender {
    for (UIButton *btn in self.btar) {
        [btn setEnabled:YES];
    }
    NSString *buttonNR = [sender currentTitle];
    NSString *labelText = [self.label text];
    NSString *newText;
    if ([buttonNR isEqualToString:@"."] && [labelText length]==0)
    {
        newText = [labelText stringByAppendingString:@"0."];
        [self.dotButton setEnabled:NO];
    }
    else
    {
        newText = [labelText stringByAppendingString:buttonNR];
        [self.dotButton setEnabled:YES];
    }
    [self.label setText:newText];
    if([self.input count]==0)
    {
        [self.input addObject:newText];
    }
    if([self.input count]==1)
    {
        [self.input removeObjectAtIndex:0];
        [self.input insertObject:newText atIndex:0];
    }
    if([self.input count]>=2)
    {
        if ([self.input count]==2)
        {
            [self.input insertObject:newText atIndex:2];
        }
        else
        {
            [self.input removeObjectAtIndex:2];
            [self.input insertObject:newText atIndex:2];
            
        }
    }
    self.stringer = @"";
    for (NSString *str in self.input) {
        
        self.stringer = [self.stringer stringByAppendingString:str];
    }
    [self.stringerLabel setText:self.stringer];
}

- (IBAction)buttonEXP:(id)sender {
    if(self.isCalc){
        NSString *result = [NSString stringWithFormat:@"%.2f", self.calcRes];
        NSArray *arrar = [result componentsSeparatedByString:@"."];
        int afterDecimal = [[arrar lastObject] intValue];
        if (afterDecimal==0)
        {
            result = [NSString stringWithFormat:@"%.0f",self.calcRes];
        }
        [self.input removeAllObjects];
        [self.input addObject:result];
    }
    NSString *buttonNR = [sender currentTitle];
    for (UIButton *btn in self.btar) {
        [btn setEnabled:NO];
        [btn setAlpha:1];
    }
    [self.input addObject:buttonNR];
    [self.label setText:@""];
    self.stringer = @"";
    for (NSString *str in self.input) {
        self.stringer = [self.stringer stringByAppendingString:str];
    }
    [self.stringerLabel setText:self.stringer];
}

- (IBAction)primalityTest:(id)sender {
    
    if ([self.input count]==1) {
        Calculator *myCalc = [[Calculator alloc] init];
        int value = [[self.input objectAtIndex:0] integerValue];
        BOOL isPrime = [myCalc checkForPrime:value];
        NSLog(@"%hhd",isPrime);
        if (isPrime) {
            NSString *str = [NSString stringWithFormat:@"%i is prime.",value];
            [self.label setText:str];
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%i is not prime.",value];
            [self.label setText:str];
        }
    }
    else if(self.isCalc){
        if(fmod(self.calcRes, 1)==0){
        Calculator *myCalc = [[Calculator alloc] init];
        int value = floor(self.calcRes*100)/100;
        BOOL isPrime = [myCalc checkForPrime:value];
        NSLog(@"%hhd",isPrime);
        if (isPrime) {
            NSString *str = [NSString stringWithFormat:@" %i is prime.",value];
            [self.label setText:str];
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%i is not prime.",value];
            [self.label setText:str];
        }
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%.2f should be integer.",self.calcRes];
            [self.label setText:str];
        }
    }
    else{
        [self.label setText:@"Invalid input."];
    }
    
}


- (IBAction)clearField:(id)sender {
    [self.label setText:@""];
    self.stringer = @"";
    self.isCalc = NO;
    self.changeUpperLabel = YES;
    [self.input removeAllObjects];
    [self.stringerLabel setText:@""];
    for (UIButton *btn in self.btar) {
        [btn setEnabled:YES];
    }
}

- (IBAction)memPlus:(id)sender {
    int inputSize = [self.input count];
    if(inputSize>0){
        if (inputSize==1) {
            [self.memory addObject:[self.input objectAtIndex:0]];
            NSLog(@"Added %@ to memory.",[self.memory objectAtIndex:[self.memory count]-1]);
        }
        else{
            if (self.isCalc) {
                NSNumber *result = [NSNumber numberWithDouble:self.calcRes];
                [self.memory addObject:[result stringValue]];
                NSLog(@"Added %@ to memory.",[self.memory objectAtIndex:[self.memory count]-1]);
            }
        }
    }
}

- (IBAction)memRecall:(id)sender {
    if([self.memory count]>0){
        if([self.input count]==2){
            [self.input addObject:[self.memory objectAtIndex: [self.memory count]-1]];
            NSLog(@"Added %@ to input.",[self.memory objectAtIndex: [self.memory count]-1]);
            self.stringer = [NSString stringWithFormat:@"%@%@%@",[self.input objectAtIndex:0],[self.input objectAtIndex:1],[self.input objectAtIndex:2]];
            [self.stringerLabel setText:self.stringer];
        }
        else if([self.input count]==0){
            [self.input addObject:[self.memory objectAtIndex: [self.memory count]-1]];
            self.stringer = [NSString stringWithFormat:@"%@",[self.memory objectAtIndex: [self.memory count]-1]];
            [self.stringerLabel setText:self.stringer];

        }
        
    }
}



- (IBAction)calculate:(id)sender {
    
    NSMutableArray *array = self.input;
    for (UIButton *btn in self.btar) {
        [btn setEnabled:YES];
    }
    if(self.isCalc){
        NSString *result = [NSString stringWithFormat:@"%.2f", self.calcRes];
        NSArray *arrar = [result componentsSeparatedByString:@"."];
        int afterDecimal = [[arrar lastObject] intValue];
        if (afterDecimal==0)
        {
            result = [NSString stringWithFormat:@"%.0f",self.calcRes];
        }
        [array replaceObjectAtIndex:0 withObject:result];
        self.stringer = [NSString stringWithFormat:@"%@%@%@=",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];
        [self.stringerLabel setText:self.stringer];
        self.changeUpperLabel = NO;
    }
    if(![array count]==0)
    {
        if (!self.isCalc)
        {
            self.stringer = [self.stringer stringByAppendingString:@"="];
            self.isCalc = YES;
        }
        if(self.changeUpperLabel)
        {
        [self.stringerLabel setText:self.stringer];
        }
        Calculator *myCalc = [[Calculator alloc] init];
        
        if ([array count]==1)
        {
            NSString *str = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
            [self.label setText:str];
            
        }
        else if([array count]==3)
        {
            self.calcRes = [myCalc calulatorWithFirstValue:[[array objectAtIndex:0] doubleValue]
                                               secondValue:[[array objectAtIndex:2] doubleValue]
                                                expression:[array objectAtIndex:1]
                                                      calc:myCalc];
            NSString *result = [NSString stringWithFormat:@"%.2f", self.calcRes];
            NSArray *arrar = [result componentsSeparatedByString:@"."];
            int afterDecimal = [[arrar lastObject] intValue];
            if (afterDecimal==0)
            {
                result = [NSString stringWithFormat:@"%.0f",self.calcRes];
            }
            [self.label setText:result];
        }
        else{
            [self.label setText:@"Wrong input."];
        }
    }
    else
    {
        [self.label setText:@"Input is empty"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.input = [[NSMutableArray alloc] init];
    self.memory= [[NSMutableArray alloc] init];
    self.stringer = @"";
    self.calcRes = 0;
    self.isCalc = NO;
    self.changeUpperLabel = YES;
    self.label.adjustsFontSizeToFitWidth = YES;
    self.btar = [NSArray arrayWithObjects:self.plusButton,self.powerButton,self.multiButton,self.minusButton,self.divButton, nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

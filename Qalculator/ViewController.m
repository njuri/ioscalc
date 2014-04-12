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
@property NSMutableArray *input;
@property NSArray *btar;
@property NSString *stringer;
@property double calcRes;
@property BOOL isCalc;

@end

@implementation ViewController

- (IBAction)buttonNR1:(id)sender {
    for (UIButton *btn in self.btar) {
        [btn setEnabled:YES];
    }
    NSString *buttonNR = [sender currentTitle];
    NSString *labelText = [self.label text];
    NSString *newText = [labelText stringByAppendingString:buttonNR];
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
    NSString *buttonNR = [sender currentTitle];
    for (UIButton *btn in self.btar) {
        [btn setEnabled:NO];
    }
    [self.input addObject:buttonNR];
    [self.label setText:@""];
    self.stringer = @"";
    for (NSString *str in self.input) {
        self.stringer = [self.stringer stringByAppendingString:str];
    }
    [self.stringerLabel setText:self.stringer];
}

- (IBAction)clearField:(id)sender {
    [self.label setText:@""];
    self.stringer = @"";
    self.isCalc = NO;
    [self.input removeAllObjects];
    [self.stringerLabel setText:@""];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)calculate:(id)sender {
    
    NSArray *array = self.input;
    
    if(![array count]==0)
    {
        if (!self.isCalc)
        {
            self.stringer = [self.stringer stringByAppendingString:@"="];
            self.isCalc = YES;
        }
        
        [self.stringerLabel setText:self.stringer];
        Calculator *myCalc = [[Calculator alloc] init];
        
        if ([array count]==1)
        {
            NSString *str = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
            [self.label setText:str];
            
        }
        else
        {
            self.calcRes = [myCalc calulatorWithFirstValue:[[array objectAtIndex:0] doubleValue]
                                               secondValue:[[array objectAtIndex:2]doubleValue]
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
    self.stringer = @"";
    self.calcRes = 0;
    self.isCalc = NO;
    self.btar = [NSArray arrayWithObjects:self.plusButton,self.powerButton,self.multiButton,self.minusButton,self.divButton, nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HeaderIngrediente.m
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "HeaderIngrediente.h"

@interface HeaderIngrediente ()

@property BOOL servingdOpen;

@end

@implementation HeaderIngrediente

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickCart:(id)sender {
    if (self.delegate) {
        [self.delegate performSelector:@selector(callCart) withObject:nil];
    }
    
    
}

- (IBAction)clckServings:(id)sender {
    
    if (self.servingdOpen)
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - self.pickerServings.frame.size.height)];
        }];
    else
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height + self.pickerServings.frame.size.height)];
        }];
    
    if (self.delegate)
    {
        [self.delegate performSelector:@selector(callPikerServings) withObject:nil afterDelay:0.0];
    }
    
    self.servingdOpen = !self.servingdOpen;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld",(long)row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 25;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
   // self.labelNumberServings.text =  [NSString stringWithFormat:@"%ld",(long)row];
}

- (IBAction)DoneServings:(id)sender
{
    self.labelNumberServings.text = [NSString stringWithFormat:@"%ld",(long)[self.pickerServings selectedRowInComponent:0]];
    [self clckServings:self];
}
@end

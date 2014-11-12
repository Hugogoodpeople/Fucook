//
//  NewIngrediente.m
//  Fucook
//
//  Created by Rundlr on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NewIngrediente.h"

@interface NewIngrediente (){
    BOOL pickerQuantA;
    BOOL pickerUnitA;
    
     NSArray *_pickerDataUnit;
}
@end

@implementation NewIngrediente

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //[button addTarget:self action:@selector(receita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsave2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    UIButton * buttonback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonback addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [buttonback setImage:[UIImage imageNamed:@"btleft2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonback = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    self.navigationItem.leftBarButtonItem = anotherButtonback;
    
    self.navigationItem.title = @"Ingredient";
    
    _pickerDataUnit = @[@"g", @"Kg", @"ml", @"dl", @"cl", @"L", @"un", @"tbsp"];
    
     self.textName.delegate=self;
     self.textQuant.delegate=self;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(pickerQuantA==0){
        [self btUnit:self];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //CGPoint scrollPoint = CGPointMake(0.0, -50);
    
    //[self.scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)handleSingleTap
{

    [self.textQuant resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btUnit:(id)sender {
    if(pickerUnitA){
        [UIView animateWithDuration:0.5 animations:^{
            [self.viewNutricao setFrame:CGRectMake(0,  self.viewUnit.frame.origin.y+self.viewUnit.frame.size.height, self.viewNutricao.frame.size.width,self.viewNutricao.frame.size.height)];
            [self.viewCobrir setFrame:CGRectMake(0, self.viewNutricao.frame.origin.y+self.viewNutricao.frame.size.height, self.viewCobrir.frame.size.width,self.viewCobrir.frame.size.height)];
            [self.viewPickerUnit setFrame:CGRectMake(0, self.viewUnit.frame.origin.y+self.viewUnit.frame.size.height, self.viewPickerUnit.frame.size.width,self.viewPickerUnit.frame.size.height)];
         }];
        pickerUnitA=0;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.viewNutricao setFrame:CGRectMake(0, self.viewPickerUnit.frame.origin.y+self.viewPickerUnit.frame.size.height, self.viewNutricao.frame.size.width,self.viewNutricao.frame.size.height)];
            [self.viewCobrir setFrame:CGRectMake(0, self.viewNutricao.frame.origin.y+self.viewNutricao.frame.size.height, self.viewCobrir.frame.size.width,self.viewCobrir.frame.size.height)];
            [self.viewPickerUnit setFrame:CGRectMake(0, self.viewUnit.frame.origin.y+self.viewUnit.frame.size.height, self.viewPickerUnit.frame.size.width,self.viewPickerUnit.frame.size.height)];
        }];
        pickerUnitA=1;
    }

}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // não precisa fazer nada aqui mas convem ter este metodo implementado
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _pickerDataUnit.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerDataUnit[row];
}



- (IBAction)btCloseUnit:(id)sender {
    long b = [self.pickerUnit selectedRowInComponent:0];
    self.labelUnit.text = [_pickerDataUnit objectAtIndex:b];
    [self btUnit:self];
}
@end

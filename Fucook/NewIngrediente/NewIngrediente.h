//
//  NewIngrediente.h
//  Fucook
//
//  Created by Rundlr on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewIngrediente : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *pickerQuantity;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerUnit;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerNutricion;

@property (weak, nonatomic) IBOutlet UIView *viewQuantity;
@property (weak, nonatomic) IBOutlet UIView *viewUnit;
@property (weak, nonatomic) IBOutlet UIView *viewNutricao;

@property (weak, nonatomic) IBOutlet UIView *viewPickerQuant;
@property (weak, nonatomic) IBOutlet UIView *viewPickerUnit;

@property (weak, nonatomic) IBOutlet UIView *viewLabel1;
@property (weak, nonatomic) IBOutlet UIView *viewLabel3;
@property (weak, nonatomic) IBOutlet UIView *viewLabel2;
@property (weak, nonatomic) IBOutlet UIView *viewCobrir;

- (IBAction)btUnit:(id)sender;
- (IBAction)btQuant:(id)sender;

- (IBAction)btCloseUnit:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelUnit;
@end

//
//  HeaderIngrediente.h
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderIngrediente : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic , assign) id delegate;
- (IBAction)clickCart:(id)sender;
- (IBAction)clckServings:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerServings;

@property (weak, nonatomic) IBOutlet UILabel *labelNumberServings;

- (IBAction)DoneServings:(id)sender;

@end

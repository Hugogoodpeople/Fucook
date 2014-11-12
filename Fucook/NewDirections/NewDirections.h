//
//  NewDirections.h
//  Fucook
//
//  Created by Rundlr on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDirections : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollDir;
- (IBAction)btFoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)btAbrir:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@property (weak, nonatomic) IBOutlet UIView *viewDown;
@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIView *viewImagem;
@property (weak, nonatomic) IBOutlet UIView *viewLabel1;
@property (weak, nonatomic) IBOutlet UIView *viewLabel2;

@end

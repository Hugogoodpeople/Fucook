//
//  IngredienteCellTableViewCell.h
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjecteIngrediente.h"

@interface IngredienteCellTableViewCell : UITableViewCell

@property ObjecteIngrediente * ingrediente;

@property (weak, nonatomic) IBOutlet UILabel *labelQtd;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitulo;
- (IBAction)clickAddRemove:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgAddRemove;

@property BOOL onCart;
-(void)addRemove:(BOOL)selecionado;

@end

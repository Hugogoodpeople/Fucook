//
//  CellIngrediente.h
//  Fucook
//
//  Created by Hugo Costa on 19/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectIngrediente.h"

@interface CellIngrediente : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelNome;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;

- (IBAction)clickRemover:(id)sender;

@property ObjectIngrediente * ingrediente;
@property (nonatomic, assign) id delegate;

@end

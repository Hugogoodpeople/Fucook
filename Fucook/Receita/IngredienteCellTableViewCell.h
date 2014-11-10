//
//  IngredienteCellTableViewCell.h
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredienteCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelMais;
@property (weak, nonatomic) IBOutlet UILabel *labelQtd;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitulo;

@end

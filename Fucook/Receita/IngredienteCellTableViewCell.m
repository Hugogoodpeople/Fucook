//
//  IngredienteCellTableViewCell.m
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "IngredienteCellTableViewCell.h"

@implementation IngredienteCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    self.labelMais.layer.cornerRadius = 18;
    self.labelMais.layer.borderColor = [UIColor blackColor].CGColor;
    self.labelMais.layer.borderWidth = 1;
}

@end

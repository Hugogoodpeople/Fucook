//
//  CellEtapa.m
//  Fucook
//
//  Created by Hugo Costa on 02/12/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "CellEtapa.h"

@implementation CellEtapa


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)clickRemover:(id)sender {
    if (self.delegate) {
        [self.delegate performSelector:@selector(removerIngrediente:) withObject:self.ingrediente];
    }
}

@end

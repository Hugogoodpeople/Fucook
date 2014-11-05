//
//  Receita.m
//  Fucook
//
//  Created by Rundlr on 04/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Receita.h"



@implementation Receita

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.cornerRadius = 10.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.backgroundColor = self.color;
    
    //self.nameLabel.text = self.title;

}

@end

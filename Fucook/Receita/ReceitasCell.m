//
//  CollectionViewCell.m
//  Notes
//
//  Created by Hugo Costa on 06/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ReceitasCell.h"

@interface ReceitasCell ()
@property (weak, nonatomic) IBOutlet UILabel *titulo;

@end

@implementation ReceitasCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10.0;
    //self.layer.borderWidth = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 10.0;
    self.clipsToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    

    
    self.titulo.text = self.title;
}

#pragma mark - Accessors

- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    self.titulo.text = self.title;
}

- (void)setColor:(UIColor *)color {
    
    _color = [color copy];
    
    self.backgroundColor = self.color;
}

#pragma mark - Methods

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    self.layer.borderColor = self.selected ? [UIColor whiteColor].CGColor : [UIColor blackColor].CGColor;
}

@end

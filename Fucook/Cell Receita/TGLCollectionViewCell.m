//
//  TGLCollectionViewCell.m
//  TGLStackedViewExample
//
//  Created by Tim Gleue on 07.04.14.
//  Copyright (c) 2014 Tim Gleue ( http://gleue-interactive.com )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <QuartzCore/QuartzCore.h>

#import "TGLCollectionViewCell.h"

@interface TGLCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tituloSep;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;
@end

@implementation TGLCollectionViewCell

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
    // self.layer.borderColor = [UIColor blackColor].CGColor;


    // Get the Layer of any view
    CALayer * l = [_imageBack layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];

    self.tituloSep.text = self.title;
}

#pragma mark - Accessors

- (void)setTitle:(NSString *)title {

    _title = [title copy];
    
    self.tituloSep.text = self.title;
}

- (void)setColor:(UIColor *)color {

    _color = [color copy];
    
    self.tituloSep.textColor = self.color;
}

#pragma mark - Methods

- (void)setSelected:(BOOL)selected {

    [super setSelected:selected];
    
   // self.layer.borderColor = self.selected ? [UIColor whiteColor].CGColor : [UIColor blackColor].CGColor;
}

@end

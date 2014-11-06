//
//  CollectionViewCell.h
//  Notes
//
//  Created by Hugo Costa on 06/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceitasCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) UIColor *color;


- (void)setTitle:(NSString *)title;
- (void)setColor:(UIColor *)color;

@end

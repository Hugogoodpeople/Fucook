//
//  ListaComprasCell.h
//  Fucook
//
//  Created by Hugo Costa on 17/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaComprasCell : UITableViewCell
@property (nonatomic, copy) void (^additionButtonTapAction)(id sender);
@property (nonatomic) BOOL additionButtonHidden;

- (void)setupWithTitle:(NSString *)title detailText:(NSString *)detailText level:(NSInteger)level additionButtonHidden:(BOOL)additionButtonHidden;
- (void)setAdditionButtonHidden:(BOOL)additionButtonHidden animated:(BOOL)animated;
@end

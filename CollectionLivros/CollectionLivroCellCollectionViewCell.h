//
//  CollectionLivroCellCollectionViewCell.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"

@interface CollectionLivroCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet FXImageView *imagemCapa;

@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UILabel *labelDescricao;
@property (weak, nonatomic) IBOutlet UIView *ViewMovel;


@end

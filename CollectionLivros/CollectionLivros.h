//
//  CollectionLivros.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionLivros : UICollectionViewController

@property (nonatomic, assign) id delegate;

@property NSMutableArray * arrayOfItems;
@property NSMutableArray * imagens;

-(void)actualizarImagens;

@end

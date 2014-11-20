//
//  DragableTableReceitas.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSDragToReorderTableViewController.h"
#import "ObjectLivro.h"

//@interface DragableTableReceitas : ATSDragToReorderTableViewController
@interface DragableTableReceitas : UITableViewController

@property NSMutableArray *arrayOfItems;
@property (nonatomic, assign) id delegate;

@property ObjectLivro * livro;

@property NSMutableArray * imagens;

-(void)actualizarImagens;


@end

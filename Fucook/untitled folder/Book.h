//
//  Books.h
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ObjectLivro.h"

@interface Book : UIViewController <UITableViewDelegate >


@property ObjectLivro * livro;

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UIImageView *imagemLivro;

@end
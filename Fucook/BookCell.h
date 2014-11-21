//
//  BookCell.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "AppDelegate.h"

@interface BookCell : UITableViewCell

@property (nonatomic , assign) id delegate;

@property (weak, nonatomic) IBOutlet UIView *viewMovel;

@property (weak, nonatomic) IBOutlet UILabel *labelTempo;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UIImageView *imageCapa;
@property (weak, nonatomic) IBOutlet UILabel *labelPagina;

@property NSManagedObject * managedObject;

- (IBAction)clickEdit:(id)sender;
- (IBAction)clickCalendario:(id)sender;
- (IBAction)clickCarrinho:(id)sender;
- (IBAction)clickRemover:(id)sender;


@end

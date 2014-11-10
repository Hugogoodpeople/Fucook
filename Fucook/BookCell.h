//
//  BookCell.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewMovel;

@property (weak, nonatomic) IBOutlet UILabel *labelTempo;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UIImageView *imageCapa;
@property (weak, nonatomic) IBOutlet UILabel *labelPagina;

- (IBAction)clickEdit:(id)sender;
- (IBAction)clickCalendario:(id)sender;
- (IBAction)clickCarrinho:(id)sender;

@end
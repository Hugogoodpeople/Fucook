//
//  ListaComprasCell.h
//  Fucook
//
//  Created by Hugo Costa on 17/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaComprasCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSub;

- (IBAction)btVer:(id)sender;
- (IBAction)btProcurar:(id)sender;
- (IBAction)btAdd:(id)sender;
- (IBAction)btDelete:(id)sender;

@end

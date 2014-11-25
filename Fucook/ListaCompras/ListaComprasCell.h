//
//  ListaComprasCell.h
//  Fucook
//
//  Created by Hugo Costa on 17/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import <CoreData/CoreData.h>

@interface ListaComprasCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSub;
@property (nonatomic , assign) id delegate;
@property NSString *index;

@property NSManagedObject * managedObject;

- (IBAction)btVer:(id)sender;
- (IBAction)btProcurar:(id)sender;
- (IBAction)btAdd:(id)sender;
- (IBAction)btDelete:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelPeso;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;
@property (weak, nonatomic) IBOutlet UILabel *labelQuanDeci;
@end

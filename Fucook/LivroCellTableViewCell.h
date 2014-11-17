//
//  LivroCellTableViewCell.h
//  Reordering
//
//  Created by Hugo Costa on 04/11/14.
//
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import <CoreData/CoreData.h>

@interface LivroCellTableViewCell : UITableViewCell

@property (nonatomic, assign) id delegate;
@property NSManagedObject * managedObject;

@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UILabel *labelDescricao;
@property (weak, nonatomic) IBOutlet FXImageView *imageCapa;


- (IBAction)ClickDelete:(id)sender;
- (IBAction)ClickEdit:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;

@property (weak, nonatomic) IBOutlet UIView *ViewMovel;

@end

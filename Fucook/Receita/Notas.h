//
//  Notas.h
//  Fucook
//
//  Created by Hugo Costa on 12/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectReceita.h"

@interface Notas : UIViewController

@property ObjectReceita * receita;

@property NSMutableArray * items;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@end

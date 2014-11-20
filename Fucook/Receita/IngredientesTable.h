//
//  Receitas.h
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectReceita.h"

@interface IngredientesTable : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@property ObjectReceita * receita;

@property NSMutableArray * items;

@property NSString * idReceita;




@end

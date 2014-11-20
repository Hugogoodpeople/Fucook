//
//  Directions.h
//  Fucook
//
//  Created by Hugo Costa on 11/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectReceita.h"
#import "AppDelegate.h"

@interface DirectionsHugo : UIViewController

@property ObjectReceita * receita;

@property NSMutableArray * items;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@end

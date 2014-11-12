//
//  DragableTableReceitas.h
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSDragToReorderTableViewController.h"

@interface DragableTableReceitas : ATSDragToReorderTableViewController {
    
    NSMutableArray *arrayOfItems;
    
}

@property (nonatomic, assign) id delegate;

@end

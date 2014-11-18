//
//  RootViewController.h
//  Reordering
//
//  Created by Daniel Shusta on 12/31/10.
//  Copyright 2010 Acacia Tree Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSDragToReorderTableViewController.h"

@interface RootViewController : ATSDragToReorderTableViewController {
	
	//NSMutableArray *arrayOfItems;
    bool userDrivenDataModelChange;
    NSManagedObjectContext * context;
}

@property (nonatomic, assign) id delegate;
@property NSMutableArray * arrayOfItems;

@property NSMutableArray * imagens;

@end

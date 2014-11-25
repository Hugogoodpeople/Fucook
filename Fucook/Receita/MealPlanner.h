//
//  MealPlanner.h
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface MealPlanner : UIViewController <iCarouselDataSource, iCarouselDelegate, UITableViewDelegate >


@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *labelMes;
- (IBAction)clickMesSeguinte:(id)sender;
- (IBAction)clickMesAnterior:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *container;

@property NSMutableArray * arrayOfItems;
@property NSMutableArray * imagens;

@property NSDate * dataActual;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

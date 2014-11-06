//
//  Home.h
//  Fucook
//
//  Created by Hugo Costa on 05/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

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

@property (weak, nonatomic) IBOutlet UIView *containerCollections;

@property (weak, nonatomic) IBOutlet UIToolbar *yoolbar;


- (IBAction)clickHome:(id)sender;
- (IBAction)clickCarrinho:(id)sender;
- (IBAction)clickAgends:(id)sender;
- (IBAction)clickInApps:(id)sender;
- (IBAction)clickSettings:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *toobar;


@end

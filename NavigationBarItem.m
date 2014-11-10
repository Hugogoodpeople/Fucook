//
//  NavigationBarItem.m
//  THTinderNavigationControllerExample
//
//  Created by Tanguy Hélesbeux on 11/10/2014.
//  Copyright (c) 2014 Tanguy Hélesbeux. All rights reserved.
//

#import "NavigationBarItem.h"

@interface NavigationBarItem()

@property (strong, nonatomic) UILabel *label;

@end

@implementation NavigationBarItem

// aqui tenho de trocar as bolas plo texto
- (UIView *)coloredView
{
    
    if (!_label) {
        /*
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = NO;
        
        _coloredView = [[UIView alloc] initWithFrame:self.bounds];
        _coloredView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_coloredView];
        */
        
        CGRect frame = CGRectMake(-50, -10, 120, 44);
        UILabel *label5 = [[UILabel alloc] initWithFrame:frame] ;
        label5.backgroundColor = [UIColor clearColor];
        label5.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.adjustsFontSizeToFitWidth = YES;
        label5.numberOfLines = 2;
        label5.minimumFontSize = 5.0;
        label5.textColor = [UIColor colorWithRed:101.0/255.0 green:112.0/255.0 blue:122.0/255.0 alpha:1];
        label5.text = @"nome";
        
        _label = label5;
        

        [self addSubview:label5];
        
    }

    return _label;
}
    


- (void)updateViewWithRatio:(CGFloat)ratio
{
    self.coloredView.alpha = 1;
    self.label.alpha = ratio+0.5;
    [self.label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20* (ratio + 0.5 )]];
    
    if (ratio == 1) {
        self.label.textColor = [UIColor colorWithRed:152.0/255.0 green:55.0/255.0 blue:150.0/255.0 alpha:1];
    }else
    {
        self.label.textColor = [UIColor colorWithRed:101.0/255.0 green:112.0/255.0 blue:122.0/255.0 alpha:1];
    }
    
}

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 

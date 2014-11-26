//
//  PlaceHolderCreateRecipe.h
//  Fucook
//
//  Created by Hugo Costa on 26/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderCreateRecipe : UIViewController
@property (weak, nonatomic) IBOutlet UIView *ViewMovel;
- (IBAction)clickAdd:(id)sender;

@property (nonatomic, assign) id delegate;

@end

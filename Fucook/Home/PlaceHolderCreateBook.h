//
//  PlaceHolderCreateBook.h
//  Fucook
//
//  Created by Hugo Costa on 18/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderCreateBook : UIViewController

@property (nonatomic, assign) id delegate;

- (IBAction)clickAdicionar:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ViewMovel;

@end

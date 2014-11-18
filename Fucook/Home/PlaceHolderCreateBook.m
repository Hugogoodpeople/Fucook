//
//  PlaceHolderCreateBook.m
//  Fucook
//
//  Created by Hugo Costa on 18/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "PlaceHolderCreateBook.h"

@interface PlaceHolderCreateBook ()

@end

@implementation PlaceHolderCreateBook

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = [UIColor colorWithRed:53.0/255.0 green:54.0/255.0 blue:58.0/255.0 alpha:1];
    
    self.ViewMovel.layer.shadowColor = [color CGColor];
    self.ViewMovel.layer.shadowRadius = 1.5f;
    self.ViewMovel.layer.shadowOpacity = .1;
    self.ViewMovel.layer.shadowOffset = CGSizeMake(5, 5);
    self.ViewMovel.layer.masksToBounds = NO;
    
    //self.ViewMovel.transform = CGAffineTransformMakeRotation(0.01f);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickAdicionar:(id)sender
{
    if (self.delegate) {
        [self.delegate performSelector:@selector(addbook) withObject:nil];
    }
}
@end

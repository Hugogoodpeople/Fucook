//
//  ReceitaController.m
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ReceitaController.h"
#import "THTinderNavigationController.h"
#import "NavigationBarItem.h"

@interface ReceitaController ()
{
    THTinderNavigationController *tinderNavigationController;
}

@end

@implementation ReceitaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUp
{
    tinderNavigationController = [[THTinderNavigationController alloc] init];
    
    UIViewController *viewController1 = [[UIViewController alloc] init];
    viewController1.view.backgroundColor = [UIColor redColor];
    UIViewController *viewController2 = [[UIViewController alloc] init];
    viewController2.view.backgroundColor = [UIColor whiteColor];
    UIViewController *viewController3 = [[UIViewController alloc] init];
    viewController3.view.backgroundColor = [UIColor blueColor];
    UIViewController *viewController4 = [[UIViewController alloc] init];
    viewController4.view.backgroundColor = [UIColor redColor];
    
    
    
    tinderNavigationController.viewControllers = @[
                                                   viewController1,
                                                   viewController2,
                                                   viewController3,
                                                   viewController4
                                                   ];
    
    tinderNavigationController.navbarItemViews = @[
                                                   [[NavigationBarItem alloc] init],
                                                   [[NavigationBarItem alloc] init],
                                                   [[NavigationBarItem alloc] init],
                                                   [[NavigationBarItem alloc] init]

                                                   ];
    
    [tinderNavigationController setCurrentPage:0 animated:NO];
    
    [tinderNavigationController.view setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, 320, 568)];
    
    [self.view addSubview:tinderNavigationController.view];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

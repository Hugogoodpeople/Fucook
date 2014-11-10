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
#import "Ingredientes.h"


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
    
    Ingredientes *viewController1 = [[Ingredientes alloc] init];
    viewController1.view.backgroundColor = [UIColor redColor];
    UIViewController *viewController2 = [[UIViewController alloc] init];
    viewController2.view.backgroundColor = [UIColor whiteColor];
    UIViewController *viewController3 = [[UIViewController alloc] init];
    viewController3.view.backgroundColor = [UIColor blueColor];
    UIViewController *viewController4 = [[UIViewController alloc] init];
    viewController4.view.backgroundColor = [UIColor redColor];
    
    
    // aqui tenho de dar tamanhos diferentes aos controladores para poder ajustar aos diferentes tipos de ecras 3.5 4  4.7 5.5
    [viewController1.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-26)];
    
    
    
    
    tinderNavigationController.viewControllers = @[
                                                   viewController1,
                                                   viewController2,
                                                   viewController3,
                                                   viewController4
                                                   ];
    
    NavigationBarItem * item1 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item2 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item3 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item4 = [[NavigationBarItem alloc] init];
    
    item1.titulo = @"Ingredients";
    item2.titulo = @"Directions";
    item3.titulo = @"Notes";
    item4.titulo = @"Nutrition";
    
    tinderNavigationController.navbarItemViews = @[
                                                   item1,
                                                   item2,
                                                   item3,
                                                   item4
                                                   ];
    
    [tinderNavigationController setCurrentPage:1 animated:NO];
    
    // tenho de detectar se esta a usar o iphone 6 ou 6+
    
    if([UIScreen mainScreen].bounds.size.height == 736)
    {
        [tinderNavigationController.view setFrame:CGRectMake(0, -64 , self.view.frame.size.width, self.view.frame.size.height)];
    }
    else if([UIScreen mainScreen].bounds.size.height == 667)
    {
        [tinderNavigationController.view setFrame:CGRectMake(0, -8 , self.view.frame.size.width, self.view.frame.size.height)];
    }
    else if([UIScreen mainScreen].bounds.size.height <= 568)
    {
        [tinderNavigationController.view setFrame:CGRectMake(0, 26 , self.view.frame.size.width, self.view.frame.size.height)];
    }
    
    NSLog(@"altura do ecra %f", [UIScreen mainScreen].bounds.size.height);

    // por algum motivo no iphone 6 e 6+ ele bate mal
    
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

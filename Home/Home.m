//
//  Home.m
//  Fucook
//
//  Created by Hugo Costa on 05/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Home.h"
#import "RootViewController.h"
#import "ReceitaCollection.h"

@interface Home ()

@property RootViewController * root;

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.root = [RootViewController new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
    
    self.root.view.backgroundColor = [UIColor clearColor];
    
    /* bt search*/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(receita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsearch"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    /* bt add*/
    UIButton * buttonadd = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //[button addTarget:self action:@selector(receita:) forControlEvents:UIControlEventTouchUpInside];
    [buttonadd setImage:[UIImage imageNamed:@"btnaddbook"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonadd = [[UIBarButtonItem alloc] initWithCustomView:buttonadd];
    
    /* bt mosaico*/
    UIButton * buttonmos= [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //[buttonmos addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [buttonmos setImage:[UIImage imageNamed:@"btnmosaic"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonmos = [[UIBarButtonItem alloc] initWithCustomView:buttonmos];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButtonadd, anotherButtonmos, nil]];
    [self.container addSubview:self.root.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)receita:(id)sender {
    NSLog(@"clicou pesquisa");
    ReceitaCollection *objYourViewController = [[ReceitaCollection alloc] initWithNibName:@"Receita" bundle:nil];
    [self.navigationController pushViewController:objYourViewController animated:YES];
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

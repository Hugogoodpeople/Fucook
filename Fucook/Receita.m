//
//  Receita.m
//  Fucook
//
//  Created by Rundlr on 06/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Receita.h"
#import "ReceitasController.h"
#import "HeaderReceita.h"

@interface Receita ()
{
     ReceitasController * cenas ;
     HeaderReceita * headerFinal;

}
@end

@implementation Receita

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    headerFinal = [HeaderReceita alloc];
    [headerFinal.view setFrame:CGRectMake(0, 0, 320, headerFinal.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    headerFinal.delegate = self;
    [self.view addSubview: headerFinal.view];
    
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(0, 0)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    cenas = [[ReceitasController alloc]initWithCollectionViewLayout:aFlowLayout];
    [cenas.view setFrame:self.view.frame];
    cenas.view.backgroundColor = [UIColor clearColor];
    cenas.collectionView.backgroundColor = [UIColor clearColor];
    //cenas.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cenas.view];

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(receita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsearch"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = anotherButton;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)receita:(id)sender {
    NSLog(@"clicou pesquisa");
   // Receita *objYourViewController = [[Receita alloc] initWithNibName:@"Receita" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    headerFinal = nil;
    cenas = nil;
}

@end

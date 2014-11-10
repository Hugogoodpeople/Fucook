//
//  Home.m
//  Fucook
//
//  Created by Hugo Costa on 05/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Home.h"
#import "RootViewController.h"

#import "CollectionLivros.h"
#import "NewBook.h"
#import "Settings.h"
#import "Book.h"

@interface Home ()

@property RootViewController * root;
@property CollectionLivros * mos;

@property bool selectedView;

@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    //self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //
    
}

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
    [buttonadd addTarget:self action:@selector(addbook:) forControlEvents:UIControlEventTouchUpInside];
    [buttonadd setImage:[UIImage imageNamed:@"btnaddbook"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonadd = [[UIBarButtonItem alloc] initWithCustomView:buttonadd];
    
    /* bt mosaico*/
    UIButton * buttonmos= [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonmos addTarget:self action:@selector(togleViews) forControlEvents:UIControlEventTouchUpInside];
    [buttonmos setImage:[UIImage imageNamed:@"btnmosaic"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonmos = [[UIBarButtonItem alloc] initWithCustomView:buttonmos];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButtonadd, anotherButtonmos, nil]];
    [self.container addSubview:self.root.view];
    
    self.root.tableView.delegate = self;
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.navigationItem setTitleView:titleView];
    
    

    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2, ([UIScreen mainScreen].bounds.size.height/2) -56 ) ];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [aFlowLayout setMinimumInteritemSpacing:0];
    [aFlowLayout setMinimumLineSpacing:0];
    self.mos = [[CollectionLivros alloc]initWithCollectionViewLayout:aFlowLayout];
    [self.mos.collectionView setBackgroundColor:[UIColor clearColor]];
    self.mos.delegate = self;
    
    
    [self.mos.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )];
    
    [self.mos.collectionView setContentInset:UIEdgeInsetsMake(64, 0, 44, 0)];
    
    
    [self.yoolbar setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.97f]];
    //[nav.navigationBar setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8f]];
    [self.yoolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.yoolbar.clipsToBounds = YES;
    
}

-(void)abrirLivro
{
    [self.navigationController pushViewController:[Book new] animated:YES];
}

-(void)togleViews
{
    if (self.selectedView) {
        [self.mos.view removeFromSuperview];
        [self.container addSubview:self.root.view];
        [self.pageControl setAlpha:1];
    }
    else
    {
        [self.root.view removeFromSuperview];
        [self.container addSubview:self.mos.view];
        [self.pageControl setAlpha:0];
    }
    
    self.selectedView = !self.selectedView;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.width ;
}

-(IBAction)addbook:(id)sender {
    NSLog(@"clicou add");

    NewBook *objYourViewController = [[NewBook alloc] initWithNibName:@"NewBook" bundle:nil];
    [self.navigationController pushViewController:objYourViewController animated:YES];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Table did Scrool %f" , scrollView.contentOffset.y);
    
    int pagina = (scrollView.contentOffset.y/self.view.frame.size.width);
    
    [self.pageControl setCurrentPage: pagina];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld", (long)indexPath.row);
    [self.navigationController pushViewController:[Book new] animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickHome:(id)sender {
}

- (IBAction)clickCarrinho:(id)sender {
}

- (IBAction)clickAgends:(id)sender {
}

- (IBAction)clickInApps:(id)sender {
}

- (IBAction)clickSettings:(id)sender
{
    [self presentViewController:[Settings new] animated:YES completion:^{}];
}
@end

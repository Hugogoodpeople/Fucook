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
#import "MealPlanner.h"
#import "PesquisaReceitas.h"
#import "AppDelegate.h"
#import "ObjectLivro.h"
#import "UIImage+fixOrientation.h"
#import "ListaCompras.h"
#import "PlaceHolderCreateBook.h"

@interface Home ()

@property RootViewController * root;
@property CollectionLivros * mos;
@property PlaceHolderCreateBook * placeHolder;

@property bool selectedView;

@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self actualizarTudo];
}

-(void)actualizarTudo
{
    [self preencherTabela];
    [self.mos actualizarImagens];
    [self.mos.collectionView reloadData];
    [self.mos.collectionView reloadItemsAtIndexPaths:[self.mos.collectionView indexPathsForVisibleItems]];
    [self.root actualizarImagens];
    
    [self.root.tableView reloadData];
    
    if (self.root.arrayOfItems.count == 0)
    {
        [self.mos.view removeFromSuperview];
        [self.root.view removeFromSuperview];
        [self.placeHolder.view removeFromSuperview];
        [self.container addSubview:self.placeHolder.view];
    }else
    {
        [self.placeHolder.view removeFromSuperview];
        [self.mos.view removeFromSuperview];
        [self.container addSubview:self.root.view];
        [self.pageControl setAlpha:1];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.root = [RootViewController new];
    self.root.delegate = self;
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
    self.root.view.backgroundColor = [UIColor clearColor];

    
    self.placeHolder = [PlaceHolderCreateBook new];
    [self.placeHolder.view setFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-88) ];

    
    self.placeHolder.delegate = self;
    
    /* bt search*/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(Findreceita) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsearch"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    /* bt add*/
    UIButton * buttonadd = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonadd addTarget:self action:@selector(addbook) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    //[self preencherTabela];
    
}



-(void)preencherTabela
{
    NSMutableArray * items = [NSMutableArray new];
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.returnsObjectsAsFaults = NO;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Livros" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        /*
        NSLog(@"************************************ Pedido ************************************");
        NSLog(@"titulo: %@", [pedido valueForKey:@"titulo"]);
        NSLog(@"descrição: %@", [pedido valueForKey:@"descricao"]);
        */
        ObjectLivro * livro = [ObjectLivro new];
        
        // para mais tarde poder apagar
        livro.managedObject = pedido;
        
        
        livro.titulo =[pedido valueForKey:@"titulo"];
        livro.descricao =[pedido valueForKey:@"descricao"];
        livro.managedObject = pedido;
        
        NSManagedObject * imagem = [pedido valueForKey:@"contem_imagem"];
        livro.imagem = imagem;
        
        [items addObject:livro];
    }


    NSArray* reversed = [[items reverseObjectEnumerator] allObjects];
    
    
    self.root.arrayOfItems = [NSMutableArray arrayWithArray:reversed];
    self.mos.arrayOfItems = [NSMutableArray arrayWithArray:reversed];
    self.pageControl.numberOfPages = reversed.count;
    
    if (reversed.count == 0)
    {
        
        [self.mos.view removeFromSuperview];
        [self.root.view removeFromSuperview];
        [self.placeHolder.view removeFromSuperview];
        [self.container addSubview:self.placeHolder.view];
    }
  
}

-(void)Findreceita
{
    [self.navigationController pushViewController:[PesquisaReceitas new] animated:YES];
}

-(void)abrirLivro:(ObjectLivro *)livro
{
    Book * receitas = [Book new];
    receitas.livro =livro;
    
    [self.navigationController pushViewController:receitas animated:YES];
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
    
    if (self.root.arrayOfItems.count == 0)
    {
        
        [self.mos.view removeFromSuperview];
        [self.root.view removeFromSuperview];
        [self.placeHolder.view removeFromSuperview];
        [self.container addSubview:self.placeHolder.view];
    }else
    {
        [self.placeHolder.view removeFromSuperview];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.width ;
}

-(void)addbook {
    NSLog(@"clicou add");

    NewBook *objYourViewController = [[NewBook alloc] initWithNibName:@"NewBook" bundle:nil];
    [self.navigationController pushViewController:objYourViewController animated:YES];
}

-(void)editBook:(NSManagedObject *) managedObject
{
    NSLog(@"clicou add");
    
    NewBook *objYourViewController = [[NewBook alloc] initWithNibName:@"NewBook" bundle:nil];
    objYourViewController.managedObject = managedObject;
    [self.navigationController pushViewController:objYourViewController animated:YES];

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"Table did Scrool %f" , scrollView.contentOffset.y);
    
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
    
    // tenho de ir buscar os valores a tabela para poder abrir o objecto correcto
    ObjectLivro * livro = [self.root.arrayOfItems objectAtIndex:indexPath.row];
    Book * recietas = [Book new];
    recietas.livro = livro;
    
    [self.navigationController pushViewController:recietas animated:YES];
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
     [self.navigationController pushViewController:[ListaCompras new] animated:YES];
}

- (IBAction)clickAgends:(id)sender {
    [self.navigationController pushViewController:[MealPlanner new] animated:YES];
}

- (IBAction)clickInApps:(id)sender {
}

- (IBAction)clickSettings:(id)sender
{
    [self presentViewController:[Settings new] animated:YES completion:^{}];
}
@end

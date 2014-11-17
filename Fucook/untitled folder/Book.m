//
//  Books.m
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Book.h"
#import "DragableTableReceitas.h"
#import "LivroCellTableViewCell.h"
#import "DirectionsHugo.h"
#import "THTinderNavigationController.h"
#import "Ingredientes.h"
#import "Notas.h"
#import "NavigationBarItem.h"
#import "NewReceita.h"
#import "Calendario.h"
#import "AppDelegate.h"


@interface Book ()

@property DragableTableReceitas * root;

@end

@implementation Book

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUp];
    
    /* bt mais*/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(addreceita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnaddbook"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = anotherButton;

    
    UIButton * buttonback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonback addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonback setImage:[UIImage imageNamed:@"btleft2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonback = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    self.navigationItem.leftBarButtonItem = anotherButtonback;
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addreceita:(id)sender {
    NSLog(@"clicou add");
    
    NewReceita *objYourViewController = [NewReceita new];
    [self.navigationController pushViewController:objYourViewController animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUp
{
    self.root = [DragableTableReceitas new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
    
    self.root.view.backgroundColor = [UIColor clearColor];
    
    [self.container addSubview:self.root.view];
    self.root.delegate = self;
    self.root.tableView.delegate = self;
    
    // tenho de carregar os livros aqui
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Livros" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    /*
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        
        NSLog(@"************************************ Pedido ************************************");
        NSLog(@"titulo: %@", [pedido valueForKey:@"titulo"]);
        NSLog(@"descrição: %@", [pedido valueForKey:@"descricao"]);
        
    }

    */
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.width ;
}

//ReceitaController


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld", (long)indexPath.row);
    //[self.navigationController pushViewController:[ReceitaController new] animated:YES];
    //[self.navigationController presentViewController:[ReceitaController new] animated:YES completion:^{}];
    
    
    
     THTinderNavigationController * tinderNavigationController = [THTinderNavigationController new];
    
    //[tinderNavigationController.view setFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-64)];
    
    
    Ingredientes *viewController1 = [[Ingredientes alloc] init];
    [viewController1.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController1.view.backgroundColor = [UIColor whiteColor];
    
    DirectionsHugo *viewController2 = [[DirectionsHugo alloc] init];
    [viewController2.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController2.view.clipsToBounds = YES;
    viewController2.view.backgroundColor = [UIColor whiteColor];
    
    Notas *viewController3 = [[Notas alloc] init];
    [viewController3.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController3.view.clipsToBounds = YES;
    viewController3.view.backgroundColor = [UIColor whiteColor];

    
    UIViewController *viewController4 = [[UIViewController alloc] init];
    viewController4.view.backgroundColor = [UIColor greenColor];
    
    
    tinderNavigationController.viewControllers = @[
                                                   viewController2,
                                                   viewController1,
                                                   viewController3,
                                                   viewController4
                                                   ];
    
    NavigationBarItem * item1 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item2 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item3 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item4 = [[NavigationBarItem alloc] init];
    
    item1.titulo = @"Directions";
    item2.titulo = @"Ingredients";
    item3.titulo = @"Notes";
    item4.titulo = @"Nutrition";
    
    tinderNavigationController.navbarItemViews = @[
                                                   item1,
                                                   item2,
                                                   item3,
                                                   item4
                                                   ];
    [tinderNavigationController setCurrentPage:1 animated:NO];
    
    
    [self.navigationController pushViewController:tinderNavigationController animated:YES];

    
    
}

-(void)editarReceita
{
    NSLog(@"Delegado Editar");
}

-(void)calendarioReceita
{
    NSLog(@"Delegado Calendario");
    [self.navigationController pushViewController:[Calendario new] animated:YES];
}

-(void)adicionarReceita
{
    NSLog(@"Delegado Adicionar");
}

@end

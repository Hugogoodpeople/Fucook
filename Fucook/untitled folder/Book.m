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
#import "IngredientesTable.h"
#import "Notas.h"
#import "NavigationBarItem.h"
#import "NewReceita.h"
#import "Calendario.h"
#import "AppDelegate.h"
#import "ObjectReceita.h"
#import "PlaceHolderCreateRecipe.h"
#import "ObjectIngrediente.h"
#import "ObjectLista.h"


@interface Book ()

@property DragableTableReceitas * root;
@property NSManagedObject * receitaAApagar;

@property PlaceHolderCreateRecipe * placeHolder;

@end

@implementation Book
@synthesize placeHolder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.root = [DragableTableReceitas new];
    self.root.livro = self.livro;
    
    
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
    
    self.root.view.backgroundColor = [UIColor clearColor];
    
    
    [self.root.view removeFromSuperview];
    [self.container addSubview:self.root.view];
    self.root.delegate = self;
    self.root.tableView.delegate = self;

    
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
    
    self.imagemLivro.image = [UIImage imageWithData:[self.livro.imagem valueForKey:@"imagem"]];
    self.labelTitulo.text = self.livro.titulo;
    
    // tenho de criar um metodo para poder listar todas as receitas dentro do livro
    
    placeHolder = [PlaceHolderCreateRecipe new];
    placeHolder.delegate = self;
   
    
    
}

-(void)actualizarTudo
{
    [self.root actualizarImagens];
    [self preencherTabela];
   
    
    [self.root.tableView reloadData];
    
    if (self.root.arrayOfItems.count == 0)
    {
        [placeHolder.view setFrame:CGRectMake(0, 70, self.container.frame.size.width, self.container.frame.size.height -140)];
        [self.root.view removeFromSuperview];
        [self.placeHolder.view removeFromSuperview];
        [self.container addSubview:self.placeHolder.view];
    }else
    {
        [self.placeHolder.view removeFromSuperview];
        [self.container addSubview:self.root.view];
       // [self.pageControl setAlpha:1];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self actualizarTudo];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addreceita:(id)sender {
    NSLog(@"clicou add");
    
    NewReceita *objYourViewController = [NewReceita new];
    objYourViewController.livro = self.livro;
    [self.navigationController pushViewController:objYourViewController animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)preencherTabela
{
    NSMutableArray * items = [NSMutableArray new];
    
    NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
    for (NSManagedObject *pedido in receitas)
    {
        ObjectReceita * receita = [ObjectReceita new];
        [receita setTheManagedObject:pedido];
        [items addObject:receita];
    }
    
    
    NSArray* reversed = [[items reverseObjectEnumerator] allObjects];
    
    
    self.root.arrayOfItems = [NSMutableArray arrayWithArray:reversed];
    
    if (reversed.count == 0)
    {
        [self.root.view removeFromSuperview];
    }
    
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
    // tenho de dar o NSmanagedObject para poder ir buscar o resto das coisas dentro de cada controlador da receita
    // tenho de mandar o objecto da receita para poder dentro de cada controlador ter a informação necessária
    
    ObjectReceita * objR = [self.root.arrayOfItems objectAtIndex:indexPath.row];
    
    IngredientesTable *viewController1 = [[IngredientesTable alloc] init];
    viewController1.receita = objR;
    [viewController1.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController1.view.backgroundColor = [UIColor whiteColor];
    
    DirectionsHugo *viewController2 = [[DirectionsHugo alloc] init];
    viewController2.receita = objR;
    [viewController2.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController2.view.clipsToBounds = YES;
    viewController2.view.backgroundColor = [UIColor whiteColor];
    
    Notas *viewController3 = [[Notas alloc] init];
    viewController3.receita = objR;
    [viewController3.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController3.view.clipsToBounds = YES;
    viewController3.view.backgroundColor = [UIColor whiteColor];

    
    tinderNavigationController.viewControllers = @[
                                                   viewController2,
                                                   viewController1,
                                                   viewController3
                                                   ];
    
    NavigationBarItem * item1 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item2 = [[NavigationBarItem alloc] init];
    NavigationBarItem * item3 = [[NavigationBarItem alloc] init];
    
    item1.titulo = @"Directions";
    item2.titulo = @"Ingredients";
    item3.titulo = @"Notes";
    
    tinderNavigationController.navbarItemViews = @[
                                                   item1,
                                                   item2,
                                                   item3
                                                   ];
    [tinderNavigationController setCurrentPage:1 animated:NO];
    
    [self.navigationController pushViewController:tinderNavigationController animated:YES];
}

-(void)editarReceita:(ObjectReceita *) receita
{
    NSLog(@"Delegado Editar");
    
    
    NewReceita *objYourViewController = [NewReceita new];
    objYourViewController.livro = self.livro;
    objYourViewController.receita = receita;
    [self.navigationController pushViewController:objYourViewController animated:YES];
}

-(void)calendarioReceita:(NSManagedObject *)receitaManaged
{
    NSLog(@"Delegado Calendario");
    Calendario * cal = [Calendario new];
    cal.receita = receitaManaged;
    
    [self.navigationController pushViewController:cal animated:YES];
}

-(void)adicionarReceita:(ObjectReceita *) receita
{
    NSLog(@"Delegado ingredientes da receita %@", receita.nome);
    /* tenho de percorrer todos os ingredientes da receita e adicionar ao carrinho de compras :( vai ter de ter varias verificações para verificar se
     * o ingrediente já se encontra ou não guardado... se já estiver guardado tenho de apagar para poder adicionar de novo com os novos valores
     */
    
    
    NSMutableArray * arrayIngredientes = [NSMutableArray new];
    
    NSSet * resultados = [receita.managedObject valueForKey:@"contem_ingredientes"];
    for ( NSManagedObject * managedIngre in resultados )
    {
        ObjectIngrediente * ingrediente = [ObjectIngrediente new];
        [ingrediente setTheManagedObject:managedIngre];
        
        [arrayIngredientes addObject:ingrediente];
    }
    
#warning tenho de ter cuidado caso já exista um ingrediente com o mesmo nome para esse ser removido
    // ok agora neste ponto já tenho todos os ingredientes da receita
    // agora tenho de verificar se esses ingredientes já existem no shopping cart
    
    NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.returnsObjectsAsFaults = NO;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ShoppingList" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError * error;
    
    NSMutableArray * arrayShoppingList = [NSMutableArray new];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject * managedItemList in fetchedObjects)
    {
        ObjectLista * objLista = [ObjectLista new];
        [objLista setTheManagedObject:managedItemList];
        
        [arrayShoppingList addObject:objLista];
    }
    
    // aqui já tenho todos os ingredientes na shoping list pertencentes a todas as receitas
    // para todos os itens da receita vou ter de correr um ciclo que verifica se o ingrediente já existe ou nao no cart
    // se existir tenho de remover
    int count = 0;
    for (ObjectIngrediente * ingrediente in arrayIngredientes)
    {
        for (ObjectLista * listItem in arrayShoppingList)
        {
            if ([ingrediente.nome isEqualToString:listItem.nome] && [ingrediente.unidade isEqualToString:listItem.unidade])
            {
                [context deleteObject:listItem.managedObject];
                count = count +1;
            }
        }
    }
    
    // aqui já apaguei os que já estavam anteriormente na lista
    // entao agora tenho de adicionar todos os que tenho na lista a base de dados com mais um ciclo
    
    
    for (ObjectIngrediente * listIgre in arrayIngredientes)
    {
        // ele aqui devia gravar os ingredientes 1 a 1 na base de dados
        [listIgre gettheManagedObjectToList: context];
        
    }
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%d ingredients added to your cart", arrayIngredientes.count - count] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
        [alert show];
    }
}

-(void)ApagarReceita:(NSManagedObject *) object
{
    NSLog(@"delegado apagar receita");
    
    self.receitaAApagar = object;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Delete recipe?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if (buttonIndex == 1)
        {
            [self apagarReceita];
        }
    }
}

-(void)apagarReceita
{
    NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    NSManagedObject * temp;
    
    // tenho de ir buscar a receita correcta ao livro para ser apagada
    NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
    
    
    // porque que eu faço isto aqui??? posso passar directamente o valor e apagar logo
    // tipo [context deleteObject:self.receitaAApagar]; // e fica feito
    [context deleteObject:self.receitaAApagar];
  
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    [self actualizarTudo];

}

@end

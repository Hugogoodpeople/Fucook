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


@interface Book ()

@property DragableTableReceitas * root;
@property NSManagedObject * receitaAApagar;

@end

@implementation Book

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.root = [DragableTableReceitas new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    //[self actualizarTudo];
    
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
    
}

-(void)actualizarTudo
{
    [self.root actualizarImagens];
    [self preencherTabela];
   
    
    [self.root.tableView reloadData];
    
    if (self.root.arrayOfItems.count == 0)
    {
        [self.root.view removeFromSuperview];
        //[self.placeHolder.view removeFromSuperview];
        //[self.container addSubview:self.placeHolder.view];
    }else
    {
        //[self.placeHolder.view removeFromSuperview];
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
        
        // para mais tarde poder apagar
        receita.managedObject   = pedido;
        receita.nome            = [pedido valueForKey:@"nome"];
        receita.dificuldade     = [pedido valueForKey:@"dificuldade"];
        receita.servings        = [pedido valueForKey:@"nr_pessoas"];
        receita.categoria       = [pedido valueForKey:@"categoria"];
        receita.tempo           = [pedido valueForKey:@"tempo"];
        receita.notas           = [pedido valueForKey:@"notas"];
        
        NSManagedObject * imagem = [pedido valueForKey:@"contem_imagem"];
        receita.imagem = imagem;
        
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
        if (buttonIndex == 1) {
            NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
            
            NSManagedObject * temp;
            
            // tenho de ir buscar a receita correcta ao livro para ser apagada
            NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
            for (NSManagedObject *pedido in receitas)
            {
                if (self.receitaAApagar == pedido) {
                    
                    temp = pedido;
                }
                
            }
            
            // depois de ter a receita uso a relação exitente entre as 2 para que o livro saiba que já não esta relacionado com a receita
            // depois de cortar a relação já posso apagar a receita
            [temp setValue:nil forKey:@"pertence_livro"];
            [context deleteObject:temp];
            
            NSError *error = nil;
            if (![context save:&error])
            {
                NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
                return;
            }
            
            [self actualizarTudo];

        }
    }
}

@end

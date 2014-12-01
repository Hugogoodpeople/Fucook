//
//  Receitas.m
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "IngredientesTable.h"
#import "HeaderIngrediente.h"
#import "IngredienteCellTableViewCell.h"
#import "ObjectIngrediente.h"
#import "AppDelegate.h"
#import "ObjectLista.h"

@interface IngredientesTable ()

@property HeaderIngrediente * header;
@property BOOL servingsOpen;
@property BOOL cartAllSelected;
@property NSMutableArray * shopingCart;

@end

@implementation IngredientesTable

NSManagedObjectContext * context ;


@synthesize header;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.cartAllSelected = YES;
    
    context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    [self initializeShoppingCart];
    [self setUp];
 
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeShoppingCart
{
    self.shopingCart = [NSMutableArray new];
    
    NSError *error;
    /*
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
     */
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.returnsObjectsAsFaults = NO;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ShoppingList" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        NSLog(@"************************************ Shopping list ************************************");
        NSLog(@"nome: %@", [pedido valueForKey:@"nome"]);
        NSLog(@"quantidade: %@", [pedido valueForKey:@"quantidade"]);
        NSLog(@"unidade: %@", [pedido valueForKey:@"unidade"]);
        ObjectLista * list = [ObjectLista new];
        
       
        [list setTheManagedObject:pedido forRecipe:self.receita];
        
        
        
        //[items addObject:list];
        
        // tenho de fazer aqui a comparação e se encontrar entao tenho de remover da base de dados
        [self.shopingCart addObject:list];
        
        
    }

}

-(void)scrollToTop
{
    
    [self.tabela scrollRectToVisible:header.view.frame animated:YES];
}

-(BOOL)verificarShoppingList:(ObjectIngrediente *) ingrediente
{
    BOOL tem = NO;
    
    
    for (ObjectLista * list in self.shopingCart) {
        if ([list.nome isEqualToString:ingrediente.nome] &&
            [list.unidade isEqualToString:ingrediente.unidade] /* &&
            [list.quantidade isEqualToString:ingrediente.quantidade] &&
            [list.quantidade_decimal isEqualToString:ingrediente.quantidadeDecimal] */)
        {
            tem = YES;
        }
    }
    
    return tem;
}

-(void)setUp
{
    // apenas para textes
    self.items = [NSMutableArray new];
    
    
    // tenho de verificar aqui se os ingredientes já estão na shopinglist
    NSSet * receitas = [self.receita.managedObject valueForKey:@"contem_ingredientes"];
    for (NSManagedObject *pedido in receitas)
    {
        ObjectIngrediente * ingred = [ObjectIngrediente new];
        
        // para mais tarde poder apagar
        ingred.managedObject        = pedido;
        ingred.nome                 = [pedido valueForKey:@"nome"];
        ingred.quantidade           = [pedido valueForKey:@"quantidade"];
        ingred.quantidadeDecimal    = [pedido valueForKey:@"quantidade_decimal"];
        ingred.unidade              = [pedido valueForKey:@"unidade"];
        ingred.selecionado          = [self verificarShoppingList:ingred];
        
        [self.items addObject:ingred];
    }
    
    
    header = [HeaderIngrediente new];
    header.delegate = self;
    
    
    header.dificuldade      = self.receita.dificuldade;
    header.tempo            = self.receita.tempo;
    header.nome             = self.receita.nome;
    header.servings         = self.receita.servings;
    NSData * data           = [self.receita.imagem valueForKey:@"imagem"];
   
    
    header.imagem = [UIImage imageWithData:data];
    
    self.tabela.tableHeaderView = header.view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"IngredienteCellTableViewCell";
    
    IngredienteCellTableViewCell *cell = (IngredienteCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IngredienteCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ObjectIngrediente * ing = [self.items objectAtIndex:indexPath.row];

    cell.LabelTitulo.text = ing.nome;
    cell.ingrediente = ing;
    // tenho de calcular com base no que esta no header
    
    cell.labelQtd.text = [self calcularValor:indexPath];
    cell.delegate = self;

    [cell addRemove: !ing.selecionado];
    
    return cell;

}

-(NSString *)calcularValor:(NSIndexPath *)indexPath
{
    ObjectIngrediente * ing = [self.items objectAtIndex:indexPath.row];

    float calculado = ([ing.quantidade floatValue] + [ing.quantidadeDecimal floatValue])  * ([header.labelNumberServings.text floatValue] / [self.receita.servings floatValue] );
    //ing.quantidade = [NSString stringWithFormat:@"%.2f %@", calculado, ing.unidade];
    
    return [NSString stringWithFormat:@"%g %@", calculado, ing.unidade];
}


-(void)callCart
{
    NSLog(@"abrir cart");
    // tenho de adicionar ou remover tudo do carrinho
    // mas quando removo tenho de arranjar forma de salvar as alteraçoes
    [self verificaMudarCartAllSelecte];
    
    if (self.cartAllSelected)
    {
        for (ObjectIngrediente * ing in self.items)
        {
            ing.selecionado = NO;
        }
    }
    else
    {
        for (ObjectIngrediente * ing in self.items)
        {
            ing.selecionado = YES;
        }
    }
    self.cartAllSelected = !self.cartAllSelected;
    [self.tabela reloadData];

    [self mostrarAlteracoesAddRemove:self.cartAllSelected];
}

-(void)verificaMudarCartAllSelecte
{
 
    BOOL muda = YES;
    for (ObjectIngrediente * ing in self.items)
    {
        if (ing.selecionado != self.cartAllSelected)
        {
            muda = NO;
        }
    }
    
    if (!muda)
    {
        self.cartAllSelected = !self.cartAllSelected;
    }
}

-(void)mostrarAlteracoesAddRemove:(BOOL)added
{
    
    if (added)
    {
        header.labelAllitensAddedRemoved.text = @"All itens added to shopping list";
    }
    else
    {
        header.labelAllitensAddedRemoved.text = @"All itens removed from shopping list";
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [header.addedRemovedView setAlpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2 options:0 animations:^{
            [header.addedRemovedView setAlpha:0];
        } completion:0];
    }];
    
}

-(void)callPikerServings
{
    NSLog(@"abrir fechar picker servings");
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tabela.tableHeaderView = header.view;
    } completion:^(BOOL finished) {
         [self.tabela reloadData];
        [self scrollToTop];
    }];
    
}

-(void)saveIngrediente:(ObjectIngrediente *) ingrediente
{
    // tenhe de verificar se o ingrediente ja foi inserido antes de poder adicionar de novo
    // quando for salvar os ingredientes tenho de ter em conta a quantidade de servings que tem de mudar os valores na tabela
    // como é que vou mudar os valores na tabela?
    
    BOOL  podeGravar = YES;
    if (self.shopingCart.count == 0) {
        podeGravar = YES;
    }
    else
    // aqui vai ter de ir buscar sempre a base de dados
    for (ObjectLista * ing in self.shopingCart)
    {
        if ([ing.nome isEqualToString:ingrediente.nome] &&
            [ing.unidade isEqualToString:ingrediente.unidade] /* &&
            [ing.quantidade isEqualToString:ingrediente.quantidade] &&
            [ing.quantidade_decimal isEqualToString:ingrediente.quantidadeDecimal] */)
        {
            podeGravar = NO;
        }
        
    }
    
    if (podeGravar)
    {
        NSLog(@"adicionar %@", ingrediente.nome);
        
        // aqui é a criar pla primeira vez tenho de criar assim
        // não existe nenhum mecanismo automatico para esta parte
        NSManagedObject *listItem = [NSEntityDescription
                                     insertNewObjectForEntityForName:@"ShoppingList"
                                     inManagedObjectContext:context];
        
        [listItem setValue:ingrediente.nome forKey:@"nome"];
        [listItem setValue:ingrediente.quantidade forKey:@"quantidade"];
        [listItem setValue:ingrediente.quantidadeDecimal forKey:@"quantidade_decimal"];
        [listItem setValue:ingrediente.unidade forKey:@"unidade"];
        [listItem setValue:self.receita.managedObject forKey:@"pertence_receita"];
        
        ObjectLista * objLista          = [ObjectLista new];
        objLista.nome                   = ingrediente.nome;
        objLista.quantidade             = ingrediente.quantidade;
        objLista.quantidade_decimal     = ingrediente.quantidadeDecimal;
        objLista.unidade                = ingrediente.unidade;
        objLista.managedObjectReceita   = self.receita.managedObject;
        
        // tenho de mudar os valores da quantidade do ingrediente antes de gravar
        
        if ([header.labelNumberServings.text floatValue] != [self.receita.servings floatValue]) {
            float calculado = ([ingrediente.quantidade floatValue] + [ingrediente.quantidadeDecimal floatValue])  * ([header.labelNumberServings.text floatValue] / [self.receita.servings floatValue] );
            [listItem setValue:[NSString stringWithFormat:@"%.2f",calculado] forKey:@"quantidade"];
            [listItem setValue:@"" forKey:@"quantidade_decimal"];
            
            objLista.quantidade         = [NSString stringWithFormat:@"%.2f",calculado];
            objLista.quantidade_decimal = @"";

        }
        [self.shopingCart addObject: objLista];
    }
   
}

-(void)deleteIngrediente:(ObjectIngrediente *) ingrediente
{
    NSLog(@"remover %@", ingrediente.nome);
    // tenho de percorrer todos os ingredientes na shopping list e remover o selecionado
    
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    /*
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    */
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.returnsObjectsAsFaults = NO;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ShoppingList" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        NSLog(@"************************************ Shopping list ************************************");
        NSLog(@"nome: %@", [pedido valueForKey:@"nome"]);
        NSLog(@"quantidade: %@", [pedido valueForKey:@"quantidade"]);
        NSLog(@"unidade: %@", [pedido valueForKey:@"unidade"]);
        ObjectLista * list = [ObjectLista new];
        
        // para mais tarde poder apagar
        list.managedObject = pedido;
        
        list.nome =[pedido valueForKey:@"nome"];
        list.quantidade =[pedido valueForKey:@"quantidade"];
        list.quantidade_decimal =[pedido valueForKey:@"quantidade_decimal"];
        list.unidade =[pedido valueForKey:@"unidade"];
        
        // [items addObject:list];
        // tenho de fazer aqui a comparação e se encontrar entao tenho de remover da base de dados
        
        if ([list.nome isEqualToString:ingrediente.nome] &&
            [list.unidade isEqualToString:ingrediente.unidade] /* &&
            [list.quantidade isEqualToString:ingrediente.quantidade] &&
            [list.quantidade_decimal isEqualToString:ingrediente.quantidadeDecimal]*/)
        {
            [context deleteObject:list.managedObject];
            [self.shopingCart removeObject: list];
        }
    }
}


@end

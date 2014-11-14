//
//  Receitas.m
//  Fucook
//
//  Created by Hugo Costa on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Ingredientes.h"
#import "HeaderIngrediente.h"
#import "IngredienteCellTableViewCell.h"
#import "ObjecteIngrediente.h"
#import "AppDelegate.h"

@interface Ingredientes ()

@property HeaderIngrediente * header;
@property BOOL servingsOpen;
@property BOOL cartAllSelected;

@end

@implementation Ingredientes

@synthesize header;

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
    // apenas para textes
    
    self.items = [NSMutableArray new];
    
    /*
    NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    
    
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Ingredientes" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    
    // aqui vou ter de fazer a magia de passa todos os pedidos
    // atenção tenho de organizar os headers por datas
    
    // ok primeiro vou passar todos os pedidos para um array de pedidos
    NSMutableArray * ingredientes = [NSMutableArray new];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *ingrediente in fetchedObjects)
    {
        if(self.idReceita [pedido valueForKey:@"id_ingrediente"])
        
        
        NSLog(@"objecto %@", ingrediente.description);
        
        ObjecteIngrediente * ing1 = [ObjecteIngrediente new];
        ing1.nome = @"Carré de borrego";
        ing1.quantidade = @"1";
        ing1.unidade = [@"kg";
        
        [self.items addObject:ing1];
        
    }
    */
     
    ObjecteIngrediente * ing1 = [ObjecteIngrediente new];
    ing1.nome = @"Carré de borrego";
    ing1.quantidade = @"1";
    ing1.unidade = @"kg";

    
    
    ObjecteIngrediente * ing2 = [ObjecteIngrediente new];
    ing2.nome = @"Abóbora";
    ing2.quantidade = @"1,5";
    ing2.unidade = @"kg";
    
    ObjecteIngrediente * ing3 = [ObjecteIngrediente new];
    ing3.nome = @"Batata";
    ing3.quantidade = @"2";
    ing3.unidade = @"kg";
    
    ObjecteIngrediente * ing4 = [ObjecteIngrediente new];
    ing4.nome = @"Figo";
    ing4.quantidade = @"150";
    ing4.unidade = @"g";
    
    ObjecteIngrediente * ing5 = [ObjecteIngrediente new];
    ing5.nome = @"Cogumelos";
    ing5.quantidade = @"200";
    ing5.unidade = @"g";
    
    [self.items addObject:ing1];
    [self.items addObject:ing2];
    [self.items addObject:ing3];
    [self.items addObject:ing4];
    [self.items addObject:ing5];

    
    
    header = [HeaderIngrediente new];
    header.delegate = self;
    
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
    /*
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
     */
    
    
    
    static NSString *simpleTableIdentifier = @"IngredienteCellTableViewCell";
    
    IngredienteCellTableViewCell *cell = (IngredienteCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IngredienteCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ObjecteIngrediente * ing = [self.items objectAtIndex:indexPath.row];

    cell.LabelTitulo.text = ing.nome;
    cell.ingrediente = ing;
    // tenho de calcular com base no que esta no header
    
    cell.labelQtd.text = [self calcularValor:indexPath];

    [cell addRemove: !ing.selecionado];
    
    return cell;

}

-(NSString *)calcularValor:(NSIndexPath *)indexPath
{
    ObjecteIngrediente * ing = [self.items objectAtIndex:indexPath.row];

    float calculado = [ing.quantidade floatValue] * [header.labelNumberServings.text floatValue];
    
    return [NSString stringWithFormat:@"%.2f %@", calculado, ing.unidade];
}


-(void)callCart
{
    NSLog(@"abrir cart");
    // tenho de adicionar ou remover tudo do carrinho
    // mas quando removo tenho de arranjar forma de salvar as alteraçoes
    [self verificaMudarCartAllSelecte];
    
    if (self.cartAllSelected){
        
        for (ObjecteIngrediente * ing in self.items) {
            ing.selecionado = NO;
        }
    }
    else
    {
        for (ObjecteIngrediente * ing in self.items) {
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
    for (ObjecteIngrediente * ing in self.items) {
        if (ing.selecionado != self.cartAllSelected) {
            muda = NO;
        }
        
    }
    
    if (!muda) {
        self.cartAllSelected = !self.cartAllSelected;
    }
}

-(void)mostrarAlteracoesAddRemove:(BOOL)added
{
    
    if (added) {
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
    }];
    
}


@end

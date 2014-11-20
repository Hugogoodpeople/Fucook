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

@interface IngredientesTable ()

@property HeaderIngrediente * header;
@property BOOL servingsOpen;
@property BOOL cartAllSelected;

@end

@implementation IngredientesTable

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
        
        
        [self.items addObject:ingred];
    }

    
    
    header = [HeaderIngrediente new];
    header.delegate = self;
    
    
    header.dificuldade      = self.receita.dificuldade;
    header.tempo            = self.receita.tempo;
    header.nome             = self.receita.nome;
    header.servings         = self.receita.servings;
    NSData * data = [self.receita.imagem valueForKey:@"imagem"];
   
    
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
    
    ObjectIngrediente * ing = [self.items objectAtIndex:indexPath.row];

    cell.LabelTitulo.text = ing.nome;
    cell.ingrediente = ing;
    // tenho de calcular com base no que esta no header
    
    cell.labelQtd.text = [self calcularValor:indexPath];

    [cell addRemove: !ing.selecionado];
    
    return cell;

}

-(NSString *)calcularValor:(NSIndexPath *)indexPath
{
    ObjectIngrediente * ing = [self.items objectAtIndex:indexPath.row];

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
        
        for (ObjectIngrediente * ing in self.items) {
            ing.selecionado = NO;
        }
    }
    else
    {
        for (ObjectIngrediente * ing in self.items) {
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
    for (ObjectIngrediente * ing in self.items) {
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

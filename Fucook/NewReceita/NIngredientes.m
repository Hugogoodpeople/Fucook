//
//  NIngredientes.m
//  Fucook
//
//  Created by Rundlr on 11/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NIngredientes.h"
#import "NewIngrediente.h"
#import "ObjectIngrediente.h"
#import "CellIngrediente.h"

@interface NIngredientes ()

@end

@implementation NIngredientes

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnewIng:(id)sender {
    NSLog(@"Clicou add");
    if(self.delegate){
        [self.delegate performSelector:@selector(novoIng) withObject:nil];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfItems.count;
    //return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
 - (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 51;
 }
 */


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *str = @"Ingredient";
    NSString *str = ((ObjectIngrediente *)[self.arrayOfItems objectAtIndex:indexPath.row]).nome;
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:17] constrainedToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width -180, 999) lineBreakMode:NSLineBreakByWordWrapping];
    
    /*
     // esta parte até calcula +- mas nao fica perfeito
     
    CGSize size = [str sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:@"HelveticaNeue" size:17]}];
    
    // Values are fractional -- you should take the ceilf to get equivalent values
    size.height = ceilf(size.height);
    size.width = ceilf(size.width);
    
     */
    NSLog(@"%f",size.height);
    if(size.height == 0)
        return 51;
        
    return size.height +30;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"CellIngrediente";
    
    
    ObjectIngrediente * ingrid = [self.arrayOfItems objectAtIndex:indexPath.row];
    
    CellIngrediente *cell = (CellIngrediente *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellIngrediente" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.clipsToBounds = YES;
        //[cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        // NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    }
    cell.ingrediente = ingrid;
    cell.delegate = self.delegate;
    
    cell.labelNome.text = ingrid.nome;
    cell.labelDesc.text = [NSString stringWithFormat:@"%@%@ %@", ingrid.quantidade, ingrid.quantidadeDecimal , ingrid.unidade];
    
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self.arrayOfItems removeObjectAtIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // tenho de mandar actualizar o controlador principar para recalcular o tamanho
        if (self.delegate) {
            [self.delegate performSelector:@selector(actualizarPosicoes) withObject:nil];
        }
        
    }
}

@end

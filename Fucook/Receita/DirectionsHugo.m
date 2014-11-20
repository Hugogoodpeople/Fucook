//
//  Directions.m
//  Fucook
//
//  Created by Hugo Costa on 11/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DirectionsHugo.h"
#import "DirectionsCell.h"
#import "DirectionsHeader.h"
#import "ObjectDirections.h"

@interface DirectionsHugo ()

@property NSMutableArray * arrayHeaders;

@end

@implementation DirectionsHugo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
}

-(void)setUp
{
   
    self.arrayHeaders = [NSMutableArray new];
    
    
    
    NSSet * receitas = [self.receita.managedObject valueForKey:@"contem_etapas"];
    int passo = 0;
    
    NSMutableArray * arrayTemp = [NSMutableArray new];
    for (NSManagedObject *pedido in receitas)
    {
        passo = passo+1;
        
        ObjectDirections * directs = [ObjectDirections new];
        
        // para mais tarde poder apagar
        //directs.managedObject         = pedido;
        directs.passo                 = passo;
        directs.descricao             = [pedido valueForKey:@"descricao"];
        
        // tenho de remover o cenas
        NSString * tempo = [pedido valueForKey:@"tempo"];
        
        directs.tempoMinutos          = tempo.intValue;

        [arrayTemp addObject:directs];
    }
    
   //  [[self.items  reverseObjectEnumerator] allObjects];
    self.items = [[NSMutableArray alloc] initWithArray:arrayTemp];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return self.items.count;
    //return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DirectionsHeader * header = [DirectionsHeader new];
    ObjectDirections * direct = [self.items objectAtIndex:section];
    header.tempo = [NSString stringWithFormat:@"%d MIN", direct.tempoMinutos];
    header.passo = [NSString stringWithFormat:@"%dº", direct.passo];
    
    
    [self.arrayHeaders addObject:header];
    
    
    return header.view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width - 0  , 9999)];
    label.numberOfLines=0;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    label.text = ((ObjectDirections *)[self.items objectAtIndex:indexPath.section]).descricao;
    
    CGSize maximumLabelSize = CGSizeMake(320, 9999);
    CGSize expectedSize = [label sizeThatFits:maximumLabelSize];
    return expectedSize.height + 35 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"DirectionsCell";
    
    DirectionsCell *cell = (DirectionsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DirectionsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ObjectDirections * direct = [self.items objectAtIndex:indexPath.section];
    
    cell.labelDescricao.text = direct.descricao;
    
    return cell;
    
}




@end

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
    self.items = [NSMutableArray new];
    self.arrayHeaders = [NSMutableArray new];
    
    // tenho de inicializar as direcçoes
    ObjectDirections * directions1 = [ObjectDirections new];
    directions1.idDirection = @"1";
    directions1.passo = 1;
    directions1.descricao = @"algum texto descritivo aqui para o passo 1";
    directions1.tempoMinutos = 5;
    
    
    ObjectDirections * directions2 = [ObjectDirections new];
    directions2.idDirection = @"2";
    directions2.passo = 2;
    directions2.descricao = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    directions2.tempoMinutos = 10;
    
    
    [self.items addObject:directions1];
    [self.items addObject:directions2];
    
    
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
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width -16  , 9999)];
    label.numberOfLines=0;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    label.text = ((ObjectDirections *)[self.items objectAtIndex:indexPath.section]).descricao;
    
    CGSize maximumLabelSize = CGSizeMake(320, 9999);
    CGSize expectedSize = [label sizeThatFits:maximumLabelSize];
    return expectedSize.height + 40 ;
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

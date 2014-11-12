//
//  Notas.m
//  Fucook
//
//  Created by Hugo Costa on 12/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Notas.h"
#import "DirectionsCell.h"
#import "NotasHeader.h"
#import "ObjectNotas.h"

@interface Notas ()


@end

@implementation Notas

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
}

-(void)setUp
{
    self.items = [NSMutableArray new];
    
    // tenho de inicializar as direcçoes
    ObjectNotas * nota1 = [ObjectNotas new];
    nota1.idNota = @"1";
    nota1.descricaoNota = @"algum texto descritivo para a nota";

    ObjectNotas * nota2 = [ObjectNotas new];
    nota2.idNota = @"2";
    nota2.descricaoNota = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    [self.items addObject:nota1];
    [self.items addObject:nota2];
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
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NotasHeader * header = [NotasHeader new];
    
    
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
    label.text = ((ObjectNotas *)[self.items objectAtIndex:indexPath.row]).descricaoNota;
    
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
    
    ObjectNotas * direct = [self.items objectAtIndex:indexPath.row];
    
    cell.labelDescricao.text = direct.descricaoNota;
    
    return cell;
    
}




@end

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

@interface Ingredientes ()

@property HeaderIngrediente * header;
@property BOOL servingsOpen;

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
    return 10;
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
    
    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    [cell setSelected:YES];
    
    return cell;

}


-(void)callCart
{
    NSLog(@"abrir cart");
}

-(void)callPikerServings
{
    NSLog(@"abrir fechar picker servings");
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tabela.tableHeaderView = header.view;
    }];
    
    
}


@end

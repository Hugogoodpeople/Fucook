//
//  ListaCompras.m
//  Fucook
//
//  Created by Hugo Costa on 14/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ListaCompras.h"
#import "RATreeView.h"

#import "ObjectLista.h"
#import "ListaComprasCell.h"

@interface ListaCompras ()

@property (strong, nonatomic) IBOutlet UITableView *tabbleView;

@end

@implementation ListaCompras

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbleView.delegate = self;
    self.tabbleView.dataSource = self;
    
    selectedIndex = -1;
    
    titleArray = [[NSMutableArray alloc] init];
    NSString *string;
    
    for(int ii=1;ii<=8;ii++){
        string = [[NSString alloc] initWithFormat:@"ROW %i",ii];
        [titleArray addObject:string];
    }
    subtitleArray = [[NSArray alloc] initWithObjects:@"1 ROW",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    textArray = [[NSArray alloc] initWithObjects:@"Manteiga",@"Amendoin",@"Sal",@"Pimenta",@"Frango",@"Batatas",@"Cenouras",@"Tomates", nil];
    
    [self.tabbleView registerNib:[UINib nibWithNibName:@"TableHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableHeader"];
    
    [self loadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [subtitleArray objectAtIndex:section];
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"ListaComprasCell";
    
    ListaComprasCell *cell = (ListaComprasCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListaComprasCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(selectedIndex == indexPath.row){
        
    }else{
        
    }
    
    cell.labelTitle.text = [textArray objectAtIndex:indexPath.row];
    cell.labelSub.text = [subtitleArray objectAtIndex:indexPath.row];
    int calc = (indexPath.row + 1)*25;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        return 87;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        selectedIndex  = -1;
        //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath.row] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    if(selectedIndex != -1){
        NSIndexPath *prev = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:prev, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (void)loadData
{
    ObjectLista *phone1 = [ObjectLista dataObjectWithName:@"Phone 1" children:nil];
    ObjectLista *phone = [ObjectLista dataObjectWithName:@"Phones"
                                                  children:[NSArray arrayWithObjects:phone1, nil]];
    
    
    ObjectLista *computer1 = [ObjectLista dataObjectWithName:@"Computer 1" children:nil];
    
    ObjectLista *computer = [ObjectLista dataObjectWithName:@"Computers"
                                                     children:[NSArray arrayWithObjects:computer1, nil]];
    ObjectLista *car = [ObjectLista dataObjectWithName:@"Cars" children:nil];
    ObjectLista *bike = [ObjectLista dataObjectWithName:@"Bikes" children:nil];
    ObjectLista *house = [ObjectLista dataObjectWithName:@"Houses" children:nil];
    ObjectLista *flats = [ObjectLista dataObjectWithName:@"Flats" children:nil];
    ObjectLista *motorbike = [ObjectLista dataObjectWithName:@"Motorbikes" children:nil];
    ObjectLista *drinks = [ObjectLista dataObjectWithName:@"Drinks" children:nil];
    ObjectLista *food = [ObjectLista dataObjectWithName:@"Food" children:nil];
    ObjectLista *sweets = [ObjectLista dataObjectWithName:@"Sweets" children:nil];
    ObjectLista *watches = [ObjectLista dataObjectWithName:@"Watches" children:nil];
    ObjectLista *walls = [ObjectLista dataObjectWithName:@"Walls" children:nil];
    
    //self.data = [NSArray arrayWithObjects:phone, computer, car, bike, house, flats, motorbike, drinks, food, sweets, watches, walls, nil];

}


@end

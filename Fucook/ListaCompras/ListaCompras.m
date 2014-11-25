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
#import "AppDelegate.h"
#import "ListaComprasCell.h"

#import "THTinderNavigationController.h"
#import "IngredientesTable.h"
#import "DirectionsHugo.h"
#import "Notas.h"
#import "NavigationBarItem.h"



@interface ListaCompras (){
     NSArray *_pickerUnit;
    NSArray *_pickerPeso;
    NSArray *_pickerData;
    NSString *indexCell;
    ObjectLista * lista;
    NSManagedObject * managedObjectaux;
}

@property (strong, nonatomic) IBOutlet UITableView *tabbleView;

@end

@implementation ListaCompras

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbleView.delegate = self;
    self.tabbleView.dataSource = self;
    [self preencherTabela];
    selectedIndex = -1;
    
    [self.tabbleView registerNib:[UINib nibWithNibName:@"TableHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableHeader"];

    [self.viewBlock setUserInteractionEnabled:NO];
    [self.viewBlock setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0]];
    
    _pickerUnit = @[@"Tbs", @"g", @"kg", @"mL", @"dL", @"L", @"Btl.", @"Bags", @"Pkgs.", @"Boxes", @"Jars"];
    _pickerPeso = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", @"70", @"80", @"90", @"100", @"125", @"150", @"175", @"200", @"250", @"300", @"350", @"400", @"450", @"500", @"600", @"700", @"750", @"800", @"900"];
    _pickerData = @[@" ",@".2", @".25", @".3", @".4", @".5", @".6", @".7", @".75", @".8", @".9"];
    
    // Connect data
    self.pickerQuant.dataSource = self;
    self.pickerQuant.delegate = self;
    
   //[self loadData];

}
-(void)preencherTabela
{
    NSMutableArray * items = [NSMutableArray new];
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
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
        
        [items addObject:list];
    }
    
    
    NSArray* reversed = [[items reverseObjectEnumerator] allObjects];
    
    
    arrayOfItems = [NSMutableArray arrayWithArray:reversed];
   // self.mos.arrayOfItems = [NSMutableArray arrayWithArray:reversed];
    //self.pageControl.numberOfPages = reversed.count;
    
    if (reversed.count == 0)
    {
        
        //[self.mos.view removeFromSuperview];
        //[self.root.view removeFromSuperview];
        //[self.placeHolder.view removeFromSuperview];
        //[self.container addSubview:self.placeHolder.view];
    }
    
    
    [self.tabbleView reloadData];
    
}








-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [subtitleArray objectAtIndex:section];
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayOfItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"ListaComprasCell";
    ObjectLista * listas = [arrayOfItems objectAtIndex:indexPath.row];
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
    NSLog(@"%@",listas.unidade);
    cell.labelTitle.text = listas.nome;
    cell.labelPeso.text = listas.quantidade;
    cell.labelUnit.text = listas.unidade;
    cell.labelQuanDeci.text = listas.quantidade_decimal;
    cell.managedObject = listas.managedObject;
    cell.index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.delegate = self;
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
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if(selectedIndex != -1){
        NSIndexPath *prev = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:prev, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)editQuant:(NSManagedObject *)managedObject{
   
    CGRect screenRect = [[UIScreen mainScreen] bounds];

        [UIView animateWithDuration:0.5 animations:^{
            [self.viewBlock setUserInteractionEnabled:YES];
            [self.viewBlock setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
            [self.viewPicker setFrame:CGRectMake(0,  screenRect.size.height-self.viewPicker.frame.size.height, self.viewPicker.frame.size.width,self.viewPicker.frame.size.height)];
            [self.tabbleView setContentSize:CGSizeMake(self.view.frame.size.width, self.tabbleView.frame.size.height-self.pickerQuant.frame.size.height)];
        }];
    //indexCell = index;
    managedObjectaux=managedObject;
}






- (void)loadData
{
    AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    
        NSManagedObject *Livro = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"ShoppingList"
                                  inManagedObjectContext:context];
    
        [Livro setValue:@"sal" forKey:@"nome"];
        [Livro setValue:@"1" forKey:@"quantidade"];
        [Livro setValue:@".4" forKey:@"quantidade_decimal"];
        [Livro setValue:@"g" forKey:@"unidade"];

        

        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
    

    /*
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
    */
    //self.data = [NSArray arrayWithObjects:phone, computer, car, bike, house, flats, motorbike, drinks, food, sweets, watches, walls, nil];

}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger num;
    if(component==0){
        num = _pickerPeso.count;
    }else if(component==1){
        num = _pickerData.count;
    }else{
       num = _pickerUnit.count;
    }
    return num;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str;
    if(component==0){
        str = _pickerPeso[row];
    }else if(component==1){
        str = _pickerData[row];
    }else{
        str = _pickerUnit[row];
    }
    return str;
}


-(IBAction)btDone:(id)sender{
    NSLog(@"%@",managedObjectaux);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
     [UIView animateWithDuration:0.5 animations:^{
        [self.viewBlock setUserInteractionEnabled:NO];
        [self.viewBlock setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0]];
        [self.viewPicker setFrame:CGRectMake(0,  screenRect.size.height+self.viewPicker.frame.size.height, self.viewPicker.frame.size.width,self.viewPicker.frame.size.height)];
        [self.tabbleView setContentSize:CGSizeMake(self.view.frame.size.width, self.tabbleView.frame.size.height-self.pickerQuant.frame.size.height)];
    }];
    
    long a = [self.pickerQuant selectedRowInComponent:0];
    NSString *quant = [_pickerPeso objectAtIndex:a];
    long b = [self.pickerQuant selectedRowInComponent:1];
    NSString *quantdecimal = [_pickerData objectAtIndex:b];
    long c = [self.pickerQuant selectedRowInComponent:2];
    NSString *uni = [_pickerUnit objectAtIndex:c];
    
    NSManagedObject *listaedit = managedObjectaux;
    
    [listaedit setValue:quant forKey:@"quantidade"];
    [listaedit setValue:quantdecimal forKey:@"quantidade_decimal"];
    [listaedit setValue:uni forKey:@"unidade"];
    
    /*NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }*/

    [self preencherTabela];

    [self.tabbleView reloadData];
}


-(void)deleteRow: (NSManagedObject *) managedObject{
    NSLog(@"deleteou");
   // NSLog(@"%@",index);
    
    
 
    
    selectedIndex = -1;
    //[self.tabbleView reloadData];
    
    
    NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    
    
    
    
    [context deleteObject:managedObject];
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }

    [self preencherTabela];
    
}

-(void)OpenReceita: (NSString *) index{
     indexCell = index;
    THTinderNavigationController * tinderNavigationController = [THTinderNavigationController new];
    
    //[tinderNavigationController.view setFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-64)];
    
    
    IngredientesTable *viewController1 = [[IngredientesTable alloc] init];
    [viewController1.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController1.view.backgroundColor = [UIColor whiteColor];
    
    DirectionsHugo *viewController2 = [[DirectionsHugo alloc] init];
    [viewController2.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-90)];
    viewController2.view.clipsToBounds = YES;
    viewController2.view.backgroundColor = [UIColor whiteColor];
    
    Notas *viewController3 = [[Notas alloc] init];
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
@end

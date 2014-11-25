//
//  MealPlanner.m
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "MealPlanner.h"
#import "DiaCalendario.h"
#import "AppDelegate.h"
#import "ObjectCalendario.h"
#import "ObjectReceita.h"
#import "MealPlanerCell.h"

@interface MealPlanner ()
{
    NSMutableArray * arrayDias;
    NSMutableArray * arrayDatas;
   // CGRect frameInicial;
}

@property (nonatomic, strong) NSMutableArray *items;
//@property TableMealPlanner * root;

@property UIView * itemAnterior;

@end

@implementation MealPlanner
@synthesize arrayOfItems, imagens;





- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
    [self setUpCoreData];
    [self setUpCarrocel];
    
}

-(void)setUp
{
    
    arrayOfItems    = [NSMutableArray new];
    imagens         = [NSMutableArray new];
    
    
   // frameInicial = self.tableView.frame;
    // para o iphone 5s
    //[self.tableView setFrame:CGRectMake(-47.5, 48, self.container.frame.size.height, self.container.frame.size.width)];
    
    // para iphone 6
    [self.tableView setBounds:CGRectMake(-47.5, 48, self.container.frame.size.height, self.container.frame.size.width)];
    
    
    
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
  
    
    //self.root = [TableMealPlanner new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    // tenho de verificar a data de hoje para meter as receitas
    
    
    //[self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width , self.container.frame.size.height)];
    
    //self.root.view.backgroundColor = [UIColor clearColor];
    
    //[self.container addSubview:self.root.view];
    //[self.root.view removeConstraints:self.root.view.constraints];
    //self.root.delegate = self;
    
    // depois tenho de activar esta parte
    //self.root.tableView.delegate = self;
    
    UIButton * buttonback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonback addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonback setImage:[UIImage imageNamed:@"btleft2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonback = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    self.navigationItem.leftBarButtonItem = anotherButtonback;
    
}

-(void)setUpCoreData
{
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    arrayDias = [NSMutableArray new];
    arrayDatas = [NSMutableArray new];
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.returnsObjectsAsFaults = NO;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Agenda" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        ObjectCalendario * dia = [ObjectCalendario new];
        dia.receitas = [NSMutableArray new];
        dia.data = [pedido valueForKey:@"data"];
        dia.categoria = [pedido valueForKey:@"categoria"];
        dia.managedObject = pedido;
        // dia.receita = [pedido valueForKey:@"contem_receitas"];
        
        NSManagedObject * receitaManaged = [pedido valueForKey:@"tem_receita"];
        NSLog(@"managed object %@", pedido.description);
      
        if (receitaManaged )
        {
            ObjectReceita * objR = [ObjectReceita new];
            [objR setTheManagedObject:receitaManaged];
            objR.categoriaAgendada = dia.categoria;
            [dia.receitas addObject:objR];
        }
       
        [arrayDias addObject:dia];
        [arrayDatas addObject:dia.data];
    }
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpCarrocel
{
    //configure carousel
    _carousel.type = iCarouselTypeLinear;
    
    if (!self.dataActual)
    {
        self.dataActual = [NSDate new];
    }
    
    
    NSDateFormatter *dateFormatterMes = [[NSDateFormatter alloc] init];
    [dateFormatterMes setDateFormat:@"MMMM yyyy"];
    self.labelMes.text = [dateFormatterMes stringFromDate:self.dataActual];
    
    
    // para o primeiro dia do mes actual
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.dataActual];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    
    
    // para ir buscar o mes actual
   // NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self.dataActual];
    
    NSDate *today = self.dataActual; //Get a date object for today's date
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:today];
    
    
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < days.length; i++)
    {
        [_items addObject:firstDayOfMonthDate];
        
        NSDate *addTime = [firstDayOfMonthDate dateByAddingTimeInterval:(24*60*60)];
        firstDayOfMonthDate = addTime;
    }
    
    
    [_carousel reloadData];
    
    
    NSDateFormatter *dateFormatterDia = [[NSDateFormatter alloc] init];
    [dateFormatterDia setDateFormat:@"dd"];
    
    int diaHoje =[dateFormatterDia stringFromDate:self.dataActual].intValue;
    
    
    [_carousel scrollToItemAtIndex:diaHoje-1 animated:false];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float altura = [[UIScreen mainScreen] bounds].size.width;
    return altura ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    NSDateFormatter *dateFormatterSemana = [[NSDateFormatter alloc] init];
    [dateFormatterSemana setDateFormat:@"EEE"];
    //NSLog(@"dia semana %@", [dateFormatter stringFromDate:[self.items objectAtIndex:index]]);
    
    NSDateFormatter *dateFormatterMes = [[NSDateFormatter alloc] init];
    [dateFormatterMes setDateFormat:@"dd"];
    //NSLog(@"dia semana %@", [dateFormatter stringFromDate:[self.items objectAtIndex:index]]);
    
    NSString * diaSemana = [dateFormatterSemana stringFromDate:[self.items objectAtIndex:index]];
    NSString * diaMes = [dateFormatterMes stringFromDate:[self.items objectAtIndex:index]];
    
    DiaCalendario * dia = [DiaCalendario new];
    dia.diaSemana = diaSemana;
    dia.dia = diaMes;

    // basta revificar se tenho algo agendado para o dia em questao
    // se sim entao tenho de mudar as cores das pintas nas celulas
    for (ObjectCalendario * cal in arrayDias)
    {
        NSString * diaString =[dateFormatterSemana stringFromDate:cal.data];
        
        if ([diaString isEqualToString:diaSemana])
        {
            // aqui tenho de verificar qual foi a refeição selecionada
            if ([cal.categoria isEqualToString:@"Breakfast"])
            {
                dia.img1Selected = true;
            }
            else if([cal.categoria isEqualToString:@"Lunch"])
            {
                dia.img2Selected = true;
            }
            else if([cal.categoria isEqualToString:@"Layoff"])
            {
                dia.img3Selected = true;
            }
            else if([cal.categoria isEqualToString:@"Dinner"])
            {
                dia.img4Selected = true;
            }
                
        }
        
    }
    
    
    return dia.view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    NSLog(@"mudou indice %ld", (long)carousel.currentItemIndex);
    
    if (self.itemAnterior) {
        DiaCalendario * dia = [DiaCalendario new];
        dia.view =self.itemAnterior;
        
        dia.ImgSelected = (UIImageView *)[dia.view viewWithTag:1];
        [UIView animateWithDuration:0.2 animations:^{
            dia.ImgSelected.alpha = 0;
           
        }];
        
        // para as sombras programaticamente
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:dia.view.bounds];
        dia.view.layer.masksToBounds = NO;
        dia.view.layer.shadowColor = [UIColor blackColor].CGColor;
        dia.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        dia.view.layer.shadowOpacity = 0.0f;
        dia.view.layer.shadowPath = shadowPath.CGPath;
        
        
    }
    
    
    // tenho de ir burcar a view actual e mudar algo para ficar diferente
    DiaCalendario * dia = [DiaCalendario new];
    dia.view =[carousel currentItemView];
    dia.ImgSelected = (UIImageView *)[dia.view viewWithTag:1];
    [UIView animateWithDuration:0.2 animations:^{
        dia.ImgSelected.alpha = 1;
    
    }];
   
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:dia.view.bounds];
    dia.view.layer.masksToBounds = NO;
    dia.view.layer.shadowColor = [UIColor blackColor].CGColor;
    dia.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    dia.view.layer.shadowOpacity = 0.5f;
    dia.view.layer.shadowPath = shadowPath.CGPath;
  
    
    
    self.itemAnterior = dia.view;
    
    
    // aqui tenho de actualizar a view que tem as receitas vindas da BD
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.dataActual];
    [components setDay:carousel.currentItemIndex +1];
    
    NSDate * scrollDay = [calendar dateFromComponents:components];
    
    NSMutableArray * itensDias = [NSMutableArray new];
    
        for (ObjectCalendario * cal in arrayDias) {
            if (cal.data == scrollDay) {
                [itensDias addObjectsFromArray: cal.receitas];
            }
        }
    
    


    
    self.arrayOfItems = itensDias;
    [self actualizarImagens];
    
    
    
    [self.tableView reloadData];
    
    
    
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.0;
    }
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    if (option == iCarouselOptionVisibleItems) {
        return 31;
    }
    return value;
}


- (IBAction)clickMesSeguinte:(id)sender
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.dataActual];
    [comp setDay:1];
    NSDateFormatter *dateFormatterMes = [[NSDateFormatter alloc] init];
    [dateFormatterMes setDateFormat:@"MM"];
    NSString * mesSeguinte = [dateFormatterMes stringFromDate:self.dataActual];

    [comp setMonth:mesSeguinte.intValue +1];
    self.dataActual = [gregorian dateFromComponents:comp];
    
    [self setUpCarrocel];
}

- (IBAction)clickMesAnterior:(id)sender
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.dataActual];
    [comp setDay:1];
    NSDateFormatter *dateFormatterMes = [[NSDateFormatter alloc] init];
    [dateFormatterMes setDateFormat:@"MM"];
    NSString * mesSeguinte = [dateFormatterMes stringFromDate:self.dataActual];
    
    [comp setMonth:mesSeguinte.intValue -1];
    self.dataActual = [gregorian dateFromComponents:comp];
    
    [self setUpCarrocel];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
     Disable reordering if there's one or zero items.
     For this example, of course, this will always be YES.
     */
    
#warning activar aqui se quiseres voltar atras para a dragable
    // [self setReorderingEnabled:( arrayOfItems.count > 1 )];
    
    return arrayOfItems.count;
}


/*
 // Override to support conditional editing of the table view.
 // This only needs to be implemented if you are going to be returning NO
 // for some items. By default, all items are editable.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return YES if you want the specified item to be editable.
 return YES;
 }
 
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 //add code here for when you hit delete
 }
 }
 */

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"MealPlanerCell";
    
    MealPlanerCell *cell = (MealPlanerCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MealPlanerCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.clipsToBounds = YES;
    // [cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    
    
    
    
    
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, [UIScreen mainScreen].bounds.size.height -180 );
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [cell.viewMovel.layer setMask:_maskingLayer];
    
    ObjectReceita * obj = [arrayOfItems objectAtIndex:indexPath.row];
    
    // aqui tenho de por a refeição da agenda :)
    cell.labelPagina.text = obj.categoriaAgendada;
    cell.labelTitulo.text = obj.nome;
    cell.labelTempo.text = obj.tempo;
    
    
    // NSString *key = [livro.imagem.description MD5Hash];
    // NSData *data = [FTWCache objectForKey:key];
    if ([imagens objectAtIndex:indexPath.row]!= [NSNull null])
    {
        //UIImage *image = [UIImage imageWithData:data];
        cell.imageCapa.image = [imagens objectAtIndex:indexPath.row];
    }
    else
    {
        //cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData * data = [obj.imagem valueForKey:@"imagem"];
            //[FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            NSInteger index = indexPath.row;
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageCapa.image = image;
                [imagens replaceObjectAtIndex:index withObject:image];
            });
        });
    }
    
    [cell setSelected:YES];
    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    cell.delegate = self;
    
    return cell;
    
}

-(float)calcularAltura
{
    int alturaEcra = [UIScreen mainScreen].bounds.size.height;
    int devolver;
    
    if (alturaEcra == 480)
    {
        devolver = 295;
    }else if (alturaEcra == 568)
    {
        devolver = 370;
    }else if (alturaEcra == 667)
    {
        devolver = 450;
    }
    else if (alturaEcra == 736)
    {
        devolver = 510;
    }
    
    return devolver;
}

-(void)actualizarImagens
{
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
    }
    
    //[self.tableView reloadData];
    
}

/*
 // should be identical to cell returned in -tableView:cellForRowAtIndexPath:
 - (UITableViewCell *)cellIdenticalToCellAtIndexPath:(NSIndexPath *)indexPath forDragTableViewController:(ATSDragToReorderTableViewController *)dragTableViewController {
 
 
 static NSString *simpleTableIdentifier = @"BookCell";
 
 MealPlanerCell *cell = (MealPlanerCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil];
 cell = [nib objectAtIndex:0];
 cell.transform = CGAffineTransformMakeRotation(M_PI/2);
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.contentView.clipsToBounds = YES;
 // [cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
 
 // NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
 
 
 
 cell.labelPagina.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
 
 
 [cell setSelected:YES];
 //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
 
 cell.delegate = self.delegate;
 
 return cell;
 
 
 }
 */

/*
	Required for drag tableview controller
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSString *itemToMove = [arrayOfItems objectAtIndex:fromIndexPath.row];
    [arrayOfItems removeObjectAtIndex:fromIndexPath.row];
    [arrayOfItems insertObject:itemToMove atIndex:toIndexPath.row];
    
}




/*
 #pragma mark -
 #pragma mark Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }
 
 
 #pragma mark -
 #pragma mark Memory management
 
 - (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Relinquish ownership any cached data, images, etc that aren't in use.
 }
 */


@end

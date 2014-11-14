//
//  MealPlanner.m
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "MealPlanner.h"
#import "DiaCalendario.h"
#import "DragableMealPlaner.h"

@interface MealPlanner ()

@property (nonatomic, strong) NSMutableArray *items;
@property DragableMealPlaner * root;

@property UIView * itemAnterior;

@end

@implementation MealPlanner





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
    
    [self setUpCarrocel];
    [self setUp];
}

-(void)setUp
{
    self.root = [DragableMealPlaner new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width , self.container.frame.size.height)];
    
    self.root.view.backgroundColor = [UIColor clearColor];
    
    [self.container addSubview:self.root.view];
    self.root.delegate = self;
    
    // depois tenho de activar esta parte
    self.root.tableView.delegate = self;
    
    UIButton * buttonback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonback addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonback setImage:[UIImage imageNamed:@"btleft2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonback = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    self.navigationItem.leftBarButtonItem = anotherButtonback;
    
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
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self.dataActual];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.width ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
    dia.diaSemana =diaSemana;
    dia.dia = diaMes;
  
    
    
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
    dia.ImgSelected = (UIImageView *)[dia.view viewWithTag:1];;
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
        return 7;
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
@end

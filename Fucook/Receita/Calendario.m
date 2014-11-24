//
//  Calendario.m
//  Fucook
//
//  Created by Hugo Costa on 12/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Calendario.h"
#import "ObjectCalendario.h"


@interface Calendario ()

@property NSMutableArray * items;
@property NSMutableArray * datas;
@property VRGCalendarView *calendar;
@property NSDate * tempDate;

@end



@implementation Calendario

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
    
    _calendar = [[VRGCalendarView alloc] init];
    _calendar.delegate=self;
    [self.container addSubview:_calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUp
{
    _items = [NSMutableArray new];
    _datas = [NSMutableArray new];
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
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
        
        dia.data = [pedido valueForKey:@"data"];
        dia.categoria = [pedido valueForKey:@"categoria"];
        dia.managedObject = pedido;
        
        
        if([pedido valueForKey:@"tem_receita"])
        {
            [_items addObject:dia];
            [_datas addObject:dia.data];
        }
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
 
    // resumindo muito eu tenho de verificar se o mes
    NSMutableArray * dias = [NSMutableArray new];
    for (NSDate * data in _datas) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:data];
        if([components month] == month)
        {
            [dias addObject:[NSNumber numberWithInteger:[components day]]];
        }
    }
    
    [calendarView markDates:dias];
}


-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    // aqui tenho de adicionar a receita a uma data
    
    self.tempDate = date;
   
    // tenho de verificar se na data actualmente escolhida ja tem alguma coisa agendada
    // se sim tenho de remover da actionsheet os que já estão escolhidos para essa data
    
    NSMutableArray * categorias = [[NSMutableArray alloc] initWithArray: @[@"Breakfast",@"Lunch",@"Layoff",@"Dinner"]];

    for (int i = 0 ; i< _datas.count ; i++)
    {
        NSDate * data = [_datas objectAtIndex:i];
        if(data == date)
        {
            ObjectCalendario * cal = [_items objectAtIndex:i];
            NSLog(@"categoria ja existente %@", cal.categoria);
            [categorias removeObject:cal.categoria];
            
        }
    }
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            nil,
                            nil];
    // ObjC Fast Enumeration
    for (NSString *title in categorias) {
        [popup addButtonWithTitle:title];
    }
    
    if (categorias.count == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Upss" message:@"All meals filled" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        popup.tag = 1;
        [popup showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag)
    {
        case 1:
        {
          
            NSString * selecionado = [popup buttonTitleAtIndex:buttonIndex];
            
            if (![selecionado isEqualToString:@"Cancel"]) {
                NSLog(@"refeição selecionada: %@", selecionado);
                [self adacionarAoCalendario:selecionado];
            }
        
        }
        default:
            break;
    }
}

-(void)adacionarAoCalendario:(NSString *)categoria
{
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    NSManagedObject *agenda = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Agenda"
                               inManagedObjectContext:context];
    
    [agenda setValue:self.tempDate forKey:@"data"];
    [agenda setValue:categoria forKey:@"categoria"];
    //[agenda setValue:self.receita forKey:@"contem_receitas"];
    
    //[self.receita setValue:agenda forKey:@"pertence_agendas"];
    
    //  tenho de fazer um ciclo dentro da receita para poder adicionar a nova agenda
    
    NSMutableArray * arrayAgenda = [NSMutableArray new];
    
    NSSet * agendamentos = [self.receita valueForKey:@"esta_agendada"];
    
    for (NSManagedObject * ag in agendamentos)
    {
        [arrayAgenda addObject:ag];
    }
    
    [self.receita setValue:[NSSet setWithArray:[[NSArray alloc] initWithArray:arrayAgenda]] forKey:@"esta_agendada"];
    
    [agenda setValue:self.receita forKey:@"tem_receita"];
    
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"error core data! %@ %@", error, [error localizedDescription]);
        return;
    }
    else
    {
        NSLog(@"Gravado com sucesso");
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}


@end

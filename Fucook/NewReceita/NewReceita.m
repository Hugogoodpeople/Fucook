//
//  NewReceita.m
//  Fucook
//
//  Created by Rundlr on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NewReceita.h"
#import "HeaderNewReceita.h"
#import "FooterNewReceita.h"
#import "NIngredientes.h"
#import "Directions.h"
#import "NewIngrediente.h"
#import "NewNotes.h"
#import "NewDirections.h"

#import "AppDelegate.h"

@interface NewReceita (){
    HeaderNewReceita * headerFinal;
    NIngredientes * ingre;
    Directions * dir;
    FooterNewReceita * footerFinal;
    
    BOOL auxIng;
    BOOL auxDir;
    BOOL auxNotes;
    
    
    NSMutableArray * arrayIngredientes;
    NSMutableArray * arraydireccoes;
    NSMutableArray * arrayNotas;
    
}

@end

@implementation NewReceita

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
    
     [self listarTodasReceitas];
}

-(void)setUp
{
    /* bt search*/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(AdicionarReceita) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsave2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    headerFinal = [HeaderNewReceita alloc];
    [headerFinal.view setFrame:CGRectMake(0, 0, headerFinal.view.frame.size.width, headerFinal.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    headerFinal.delegate = self;
    [self.scrollNewReceita addSubview: headerFinal.view];
    
    ingre = [NIngredientes alloc];
    [ingre.view setFrame:CGRectMake(0,  headerFinal.view.frame.size.height , ingre.view.frame.size.width, ingre.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    ingre.delegate = self;
    [self.scrollNewReceita addSubview: ingre.view];
    
    dir = [Directions alloc];
    [dir.view setFrame:CGRectMake(0,  headerFinal.view.frame.size.height+ingre.view.frame.size.height , dir.view.frame.size.width, dir.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    dir.delegate = self;
    [self.scrollNewReceita addSubview: dir.view];
    
    footerFinal = [FooterNewReceita alloc];
    [footerFinal.view setFrame:CGRectMake(0,  headerFinal.view.frame.size.height+ingre.view.frame.size.height+dir.view.frame.size.height, footerFinal.view.frame.size.width, footerFinal.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    footerFinal.delegatef = self;
    [self.scrollNewReceita addSubview: footerFinal.view];
    
    [self.scrollNewReceita setContentSize:CGSizeMake(self.view.frame.size.width, headerFinal.view.frame.size.height+footerFinal.view.frame.size.height+dir.view.frame.size.height+ingre.view.frame.size.height)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"Your Recipe";
    

    // inicializar os arrays
    arrayIngredientes = [NSMutableArray new];
    arraydireccoes    = [NSMutableArray new];
    arrayNotas        = [NSMutableArray new];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AdicionarReceita
{
    NSLog(@"adicionar receita");
#warning tenho de fazer todo o codigo de de adicionar a base de dados aqui
    
    AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;

    NSManagedObject *Receita = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Receitas"
                              inManagedObjectContext:context];
    
    NSString * nomeReceita = headerFinal.textName.text;
    
    [Receita setValue:nomeReceita forKey:@"nome"];
    
    NSManagedObject *Imagem = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Imagens"
                               inManagedObjectContext:context];
    
    
    
    //[self.livro.managedObject setValue:Receita forKey:@"contem_receitas"];
    // tenho de adicionar um array com o novo elemento
    
    NSMutableArray * arrayReceitas = [NSMutableArray new];
    
    NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
    
    for (NSManagedObject * rec in receitas)
    {
        [arrayReceitas addObject:rec];
    }
    
    NSData *imageData = UIImageJPEGRepresentation(headerFinal.img.image, 0.15);
    [Imagem setValue:imageData forKey:@"imagem"];
    [Receita setValue:Imagem forKey:@"contem_imagem"];
    
    [arrayReceitas addObject:Receita];
    
    
    
    [self.livro.managedObject setValue:[NSSet setWithArray:[[NSArray alloc] initWithArray:arrayReceitas]]  forKey:@"contem_receitas"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }

    [self listarTodasReceitas];
    
}

-(void)listarTodasReceitas
{
    
    // tenho de fazer de maneira a apenas listar as receitas de um livro
    
    NSManagedObjectContext *context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    // para ver se deu algum erro ao inserir
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    // para ir buscar os dados prestendidos a base de dados
        NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
        for (NSManagedObject * receita in receitas) {
            NSLog(@"************************** Receita ***************************");
            NSLog(@"Nome receita: %@", [receita valueForKey:@"nome"]);
        }
}

-(void)novoIng{
    NewIngrediente *obj = [NewIngrediente new];
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)novoNote{
    NewNotes *obj = [NewNotes new];
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)novoDir{
    NewDirections *obj = [NewDirections new];
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)animarIngre:(NSNumber *) num outro:(NSNumber *) num2{
     NSLog(@"Num1 %d", auxIng);
    if(auxIng==0){
        [UIView animateWithDuration:0.5 animations:^{
            [ingre.view setFrame:CGRectMake(0, num.floatValue, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [dir.view setFrame:CGRectMake(0, ingre.view.frame.origin.y+ingre.view.frame.size.height, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [footerFinal.view setFrame:CGRectMake(0, dir.view.frame.origin.y+dir.view.frame.size.height, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [self.scrollNewReceita setContentSize:CGSizeMake(self.view.frame.size.width, headerFinal.view.frame.size.height+footerFinal.view.frame.size.height+dir.view.frame.size.height+ingre.view.frame.size.height+num2.floatValue)];
        }];
        auxIng=1;
        NSLog(@"Num2 %d", auxIng);
        NSLog(@"tamanho o ingredi: %f", ingre.view.frame.size.height);
         NSLog(@"tamanho o dir: %f", dir.view.frame.size.height);
         //NSLog(@"tamanho o ingredi: %f", ingre.view.frame.origin.y+ingre.view.frame.size.height);
    }else if(auxIng==1){
        [UIView animateWithDuration:0.5 animations:^{
            [ingre.view setFrame:CGRectMake(0, num.floatValue, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [dir.view setFrame:CGRectMake(0, ingre.view.frame.origin.y+ingre.view.frame.size.height, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [footerFinal.view setFrame:CGRectMake(0, dir.view.frame.origin.y+dir.view.frame.size.height, ingre.view.frame.size.width, ingre.view.frame.size.height )];
            [self.scrollNewReceita setContentSize:CGSizeMake(self.view.frame.size.width, headerFinal.view.frame.size.height+footerFinal.view.frame.size.height+dir.view.frame.size.height+ingre.view.frame.size.height-num2.floatValue+10)];
        }];
        auxIng=0;
         NSLog(@"Num3 %d", auxIng);
        NSLog(@"tamanho o ingredi: %f", ingre.view.frame.origin.y+ingre.view.frame.size.height);
        NSLog(@"tamanho o dir: %f", dir.view.frame.origin.y+dir.view.frame.size.height);

    }
    
}
@end

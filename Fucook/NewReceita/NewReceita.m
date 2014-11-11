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

@interface NewReceita (){
    HeaderNewReceita * headerFinal;
    NIngredientes * ingre;
    Directions * dir;
    FooterNewReceita * footerFinal;
}

@end

@implementation NewReceita

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    //[self.scrollNewReceita setContentSize:CGSizeMake(320, 1000)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end

//
//  DiaCalendario.m
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DiaCalendario.h"

@interface DiaCalendario ()

@end

@implementation DiaCalendario

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.labelDiaSemana.text = self.diaSemana;
    self.lableDia.text = self.dia;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ok aqui tenho de ir verificar se tenho ou nao algo reservado neste dia
// ou tenho algum lado onde possa fazer isto melhor



@end

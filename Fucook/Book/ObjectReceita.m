//
//  ObjectReceita.m
//  Fucook
//
//  Created by Hugo Costa on 18/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ObjectReceita.h"

@implementation ObjectReceita


-(void)setTheManagedObject:(NSManagedObject *)managedObject
{
    self.nome = [managedObject valueForKey:@"nome"];
    self.categoria = [managedObject valueForKey:@"categoria"];
    self.servings = [managedObject valueForKey:@"nr_pessoas"];
    self.dificuldade = [managedObject valueForKey:@"dificuldade"];
    self.tempo = [managedObject valueForKey:@"tempo"];
    self.imagem = [managedObject valueForKey:@"contem_imagem"];
    self.managedObject = managedObject;
    
}

@end

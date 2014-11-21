//
//  ObjecteIngrediente.h
//  Fucook
//
//  Created by Hugo Costa on 11/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ObjectIngrediente : NSObject

@property NSString * nome;
@property NSString * idIng;
@property NSString * idReceita;
@property NSString * unidade;
@property NSString * quantidadeDecimal;
@property NSString * quantidade;
@property NSString * nutricao;
@property BOOL selecionado;
@property NSManagedObject * managedObject;

-(NSManagedObject *)getManagedObject:(NSManagedObjectContext *)context;

@end
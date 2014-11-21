//
//  ObjectReceita.h
//  Fucook
//
//  Created by Hugo Costa on 18/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ObjectReceita : NSObject

@property NSString * nome;
@property NSString * tempo;
@property NSString * dificuldade;
@property NSString * categoria;
@property NSString * servings;
@property NSString * notas;
@property NSManagedObject * imagem;
@property NSManagedObject * managedObject;

-(void)setTheManagedObject:(NSManagedObject *)managedObject;

@end

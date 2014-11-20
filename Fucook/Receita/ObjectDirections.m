//
//  ObjectDirections.m
//  Fucook
//
//  Created by Hugo Costa on 12/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ObjectDirections.h"

@implementation ObjectDirections


-(NSManagedObject *)getManagedObject:(NSManagedObjectContext *)context
{
    NSManagedObject *mangDirection = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"Etapas"
                                        inManagedObjectContext:context];
    
    [mangDirection setValue:self.idDirection forKey:@"id_etapa"];
    [mangDirection setValue:[NSString stringWithFormat:@"%d", self.tempoMinutos] forKey:@"tempo"];
    [mangDirection setValue:self.descricao forKey:@"descricao"];
    [mangDirection setValue:[NSString stringWithFormat:@"%d", self.passo] forKey:@"ordem"];
    
    return mangDirection;
}

- (NSComparisonResult)compare:(ObjectDirections *)otherObject {
    
    NSString * primeiro = [NSString stringWithFormat:@"%d", self.passo];
    NSString * segundo  = [NSString stringWithFormat:@"%d", otherObject.passo];
    
    return [primeiro compare:segundo];
}



@end

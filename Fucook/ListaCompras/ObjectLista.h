//
//  ObjectLista.h
//  Fucook
//
//  Created by Hugo Costa on 17/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectLista : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *children;

- (id)initWithName:(NSString *)name children:(NSArray *)array;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children;

- (void)addChild:(id)child;
- (void)removeChild:(id)child;

@end

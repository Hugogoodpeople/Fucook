//
//  ListaComprasCell.m
//  Fucook
//
//  Created by Hugo Costa on 17/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ListaComprasCell.h"
#import "THTinderNavigationController.h"
#import "Ingredientes.h"
#import "DirectionsHugo.h"
#import "Notas.h"



@interface ListaComprasCell(){

 BOOL aux;
}
@end

@implementation ListaComprasCell

- (void)awakeFromNib {
    [super awakeFromNib];

}



- (IBAction)btVer:(id)sender {
     NSLog(@"VER");
    if (self.delegate) {
        [self.delegate performSelector:@selector(OpenReceita:) withObject:self.index];
    }
}

- (IBAction)btProcurar:(id)sender {
     NSLog(@"PROCURAR");
}

- (IBAction)btAdd:(id)sender {
    if (self.delegate) {
        [self.delegate performSelector:@selector(editQuant:) withObject:self.index];
    }
}

- (IBAction)btDelete:(id)sender {
    NSLog(@"DELETE");
    if (self.delegate) {
        [self.delegate performSelector:@selector(deleteRow:) withObject:self.index];
    }
}
@end

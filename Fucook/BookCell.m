//
//  BookCell.m
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

- (void)awakeFromNib {
    // Initialization code
    [self setupViewMovel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;

    [self.contentView addGestureRecognizer:swipeDown];
    [self.contentView addGestureRecognizer:swipeUp];
    
}


- (void)handlePanGesture:(UISwipeGestureRecognizer *)sender
{
    
    NSLog(@"Direcção do gesto %d",sender.direction );
    if (sender.direction == UISwipeGestureRecognizerDirectionUp)
    {
        // se moveu para cima tem de fazer scroll
        [self irParaTopo];
        NSLog(@"moveu para cima ");
    }
    else
    {
        // para baixo tem de voltar ao estado inicial
        [self irParaFundo];
        NSLog(@"moveu para baixo ");
    }
    
    
}

-(void)irParaTopo
{
    int x = self.viewMovel.frame.origin.x;
    
    int height = self.viewMovel.frame.size.height;
    int width = self.viewMovel.frame.size.width;
    
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.viewMovel setFrame:CGRectMake(x, 22, width, height)];
    }];
    
    int altura = [[UIScreen mainScreen] bounds].size.height;
    
    NSLog(@"Tamanho da movel %d %d altura=%d", width, height, altura);
    
}

-(void)irParaFundo
{
    
    
    int x = self.viewMovel.frame.origin.x;
    
    int height = self.viewMovel.frame.size.height;
    int width = self.viewMovel.frame.size.width;
    
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.viewMovel setFrame:CGRectMake(x, 72, width, height)];
    }];
    
    int altura = [[UIScreen mainScreen] bounds].size.height;
    
    NSLog(@"Tamanho da movel %d %d altura=%d", width, height, altura);
}





// tenho de fazer uma verificaçao para os diferentes tamanhos de ecra
-(void)setupViewMovel
{
    // para as sombras
    
    
   /*
    [self.imageCapa setImage:[UIImage imageNamed:@"imgsample001.jpg"]];
    
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = self.viewMovel.bounds;
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [self.viewMovel.layer setMask:_maskingLayer];
    */
    
}



- (IBAction)clickEdit:(id)sender
{
    NSLog(@"Edit");
    if (self.delegate) {
        [self.delegate performSelector:@selector(editarReceita) withObject:nil];
    }
    
}

- (IBAction)clickCalendario:(id)sender
{
    NSLog(@"Calendario");
    if (self.delegate) {
        [self.delegate performSelector:@selector(calendarioReceita:) withObject:self.managedObject];
    }
}
- (IBAction)clickCarrinho:(id)sender
{
    NSLog(@"Carrinho");
    if (self.delegate) {
        [self.delegate performSelector:@selector(adicionarReceita) withObject:nil];
    }
}

- (IBAction)clickRemover:(id)sender {
    
    NSLog(@"Remover Receita");
    if (self.delegate) {
        [self.delegate performSelector:@selector(ApagarReceita:) withObject:self.managedObject];
    }
}
@end

//
//  LivroCellTableViewCell.m
//  Reordering
//
//  Created by Hugo Costa on 04/11/14.
//
//

#import "LivroCellTableViewCell.h"

@implementation LivroCellTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    
    
    [self.contentView addGestureRecognizer:swipeDown];
    [self.contentView addGestureRecognizer:swipeUp];
    
    
    UIColor *color = [UIColor colorWithRed:53.0/255.0 green:54.0/255.0 blue:58.0/255.0 alpha:1];
    
    
    self.labelTitulo.layer.shadowColor = [color CGColor];
    self.labelTitulo.layer.shadowRadius = 4.0f;
    self.labelTitulo.layer.shadowOpacity = .9;
    self.labelTitulo.layer.shadowOffset = CGSizeZero;
    self.labelTitulo.layer.masksToBounds = NO;
    
    self.labelDescricao.layer.shadowColor = [color CGColor];
    self.labelDescricao.layer.shadowRadius = 4.0f;
    self.labelDescricao.layer.shadowOpacity = .9;
    self.labelDescricao.layer.shadowOffset = CGSizeZero;
    self.labelDescricao.layer.masksToBounds = NO;
    
    
    /*
    self.contentView.layer.shadowColor = [color CGColor];
    self.contentView.layer.shadowRadius = 4.0f;
    self.contentView.layer.shadowOpacity = .9;
    self.contentView.layer.shadowOffset = CGSizeZero;
    self.contentView.layer.masksToBounds = NO;
    */
    // self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
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
    int x = self.ViewMovel.frame.origin.x;
    
    int height = self.ViewMovel.frame.size.height;
    int width = self.ViewMovel.frame.size.width;
    
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.ViewMovel setFrame:CGRectMake(x, 22, width, height)];
    }];
}

-(void)irParaFundo
{
    int x = self.ViewMovel.frame.origin.x;
    
    int height = self.ViewMovel.frame.size.height;
    int width = self.ViewMovel.frame.size.width;
    
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.ViewMovel setFrame:CGRectMake(x, 72, width, height)];
    }];
}






- (IBAction)ClickDelete:(id)sender {
    NSLog(@"Click Delete");
}

- (IBAction)ClickEdit:(id)sender {
     NSLog(@"Click Edit");
}
@end

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
        [self.ViewMovel setFrame:CGRectMake(x, -22, width, height)];
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

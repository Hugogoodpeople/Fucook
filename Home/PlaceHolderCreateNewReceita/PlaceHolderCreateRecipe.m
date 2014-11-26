//
//  PlaceHolderCreateRecipe.m
//  Fucook
//
//  Created by Hugo Costa on 26/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "PlaceHolderCreateRecipe.h"

@interface PlaceHolderCreateRecipe ()

@end

@implementation PlaceHolderCreateRecipe

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // se tem mascara nao adianta meter sombra porque nao aparece
    /*
    UIColor *color = [UIColor colorWithRed:53.0/255.0 green:54.0/255.0 blue:58.0/255.0 alpha:1];
    
    self.ViewMovel.layer.shadowColor = [color CGColor];
    self.ViewMovel.layer.shadowRadius = 1.5f;
    self.ViewMovel.layer.shadowOpacity = .1;
    self.ViewMovel.layer.shadowOffset = CGSizeMake(5, 5);
    self.ViewMovel.layer.masksToBounds = NO;
    */
    
  
    float altura = [self calcularAltura];
    
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width -30 , altura);
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [self.ViewMovel.layer setMask:_maskingLayer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)calcularAltura
{
    int alturaEcra = [UIScreen mainScreen].bounds.size.height;
    int devolver;
    
    if (alturaEcra == 480)
    {
        devolver = 275;
    }else if (alturaEcra == 568)
    {
        devolver = 340;
    }else if (alturaEcra == 667)
    {
        devolver = 430;
    }
    else if (alturaEcra == 736)
    {
        devolver = 485;
    }
    
    return devolver;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickAdd:(id)sender
{
    if (self.delegate) {
        [self.delegate performSelector:@selector(addreceita:) withObject:nil ];
    }
}
@end

//
//  NIngredientes.m
//  Fucook
//
//  Created by Rundlr on 11/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NIngredientes.h"
#import "NewIngrediente.h"

@interface NIngredientes ()

@end

@implementation NIngredientes

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnewIng:(id)sender {
    NSLog(@"Clicou add");
    if(self.delegate){
        [self.delegate performSelector:@selector(novoIng) withObject:nil];
    }
}
@end

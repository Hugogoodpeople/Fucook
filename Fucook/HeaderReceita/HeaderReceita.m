//
//  HeaderReceita.m
//  TGLStackedViewExample
//
//  Created by Rundlr on 05/11/14.
//  Copyright (c) 2014 Tim Gleue • interactive software. All rights reserved.
//

#import "HeaderReceita.h"

@interface HeaderReceita ()

@end

@implementation HeaderReceita

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

- (IBAction)clickBottun:(id)sender {
    if(self.delegate){
        [self.delegate performSelector:@selector(voltar) withObject:nil];
    }
}
@end

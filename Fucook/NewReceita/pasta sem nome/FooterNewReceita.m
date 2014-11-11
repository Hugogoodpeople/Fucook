//
//  FooterNewReceita.m
//  Fucook
//
//  Created by Rundlr on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "FooterNewReceita.h"

@interface FooterNewReceita ()

@end

@implementation FooterNewReceita

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

- (IBAction)btNewNotes:(id)sender {
    if(self.delegatef){
        [self.delegatef performSelector:@selector(novoNote) withObject:nil];
    }
}
@end

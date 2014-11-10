//
//  NewReceita.m
//  Fucook
//
//  Created by Rundlr on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NewReceita.h"
#import "HeaderNewReceita.h"

@interface NewReceita (){
    HeaderNewReceita * headerFinal;

}

@end

@implementation NewReceita

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerFinal = [HeaderNewReceita alloc];
    [headerFinal.view setFrame:CGRectMake(0, 40, headerFinal.view.frame.size.width, headerFinal.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;
    headerFinal.delegate = self;
    [self.view addSubview: headerFinal.view];
    
    [self.scrollViewReceita setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

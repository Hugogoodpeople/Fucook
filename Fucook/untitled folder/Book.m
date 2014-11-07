//
//  Books.m
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Book.h"
#import "DragableTableReceitas.h"
#import "LivroCellTableViewCell.h"
#import "HeaderNewReceita.h"

@interface Book ()

@property DragableTableReceitas * root;

@end

@implementation Book

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUp];
    
    /* bt search*/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button addTarget:self action:@selector(addreceita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnaddbook"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = anotherButton;

    
}

-(IBAction)addreceita:(id)sender {
    NSLog(@"clicou add");
    
    HeaderNewReceita *objYourViewController = [[HeaderNewReceita alloc] initWithNibName:@"HeaderNewReceita" bundle:nil];
    [self.navigationController pushViewController:objYourViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(void)setUp
{
    self.root = [DragableTableReceitas new];
    //[self.root.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.root.view setFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
    
    self.root.view.backgroundColor = [UIColor clearColor];
    
    [self.container addSubview:self.root.view];
    
    self.root.tableView.delegate = self;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.width ;
}



@end

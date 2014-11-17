//
//  ListaCompras.m
//  Fucook
//
//  Created by Hugo Costa on 14/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ListaCompras.h"
#import "RATreeView.h"

@interface ListaCompras () <RATreeViewDelegate, RATreeViewDataSource>

@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) RATreeView *treeView;


@end

@implementation ListaCompras

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    RATreeView *treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];

    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    [treeView reloadData];
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    
    
    self.treeView = treeView;
    [self.view insertSubview:treeView atIndex:0];
    
    //[self.navigationController setNavigationBarHidden:NO];
    
    //[self updateNavigationItemButton];
    
    //[self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([RATableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RATableViewCell class])];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item
{
    return YES;
}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    //RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    //[cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    //RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    //[cell setAdditionButtonHidden:YES animated:YES];
}

- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item
{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
   /*RADataObject *parent = [self.treeView parentForItem:item];
    NSInteger index = 0;
    
    if (parent == nil) {
        index = [self.data indexOfObject:item];
        NSMutableArray *children = [self.data mutableCopy];
        [children removeObject:item];
        self.data = [children copy];
        
    } else {
        index = [parent.children indexOfObject:item];
        [parent removeChild:item];
    }
    
    [self.treeView deleteItemsAtIndexes:[NSIndexSet indexSetWithIndex:index] inParent:parent withAnimation:RATreeViewRowAnimationRight];
    if (parent) {
        [self.treeView reloadRowsForItems:@[parent] withRowAnimation:RATreeViewRowAnimationNone];
    }*/
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    /*RADataObject *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    RATableViewCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([RATableViewCell class])];
    [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    cell.additionButtonTapAction = ^(id sender){
        if (![weakSelf.treeView isCellForItemExpanded:dataObject] || weakSelf.treeView.isEditing) {
            return;
        }
        RADataObject *newDataObject = [[RADataObject alloc] initWithName:@"Added value" children:@[]];
        [dataObject addChild:newDataObject];
        [weakSelf.treeView insertItemsAtIndexes:[NSIndexSet indexSetWithIndex:0] inParent:dataObject withAnimation:RATreeViewRowAnimationLeft];
        [weakSelf.treeView reloadRowsForItems:@[dataObject] withRowAnimation:RATreeViewRowAnimationNone];
    };
    */
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    //RADataObject *data = item;
    //return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    //RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    //return data.children[index];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadData
{
    /*RADataObject *phone1 = [RADataObject dataObjectWithName:@"Phone 1" children:nil];
    RADataObject *phone2 = [RADataObject dataObjectWithName:@"Phone 2" children:nil];
    RADataObject *phone3 = [RADataObject dataObjectWithName:@"Phone 3" children:nil];
    RADataObject *phone4 = [RADataObject dataObjectWithName:@"Phone 4" children:nil];
    
    RADataObject *phone = [RADataObject dataObjectWithName:@"Phones"
                                                  children:[NSArray arrayWithObjects:phone1, phone2, phone3, phone4, nil]];
    
    RADataObject *notebook1 = [RADataObject dataObjectWithName:@"Notebook 1" children:nil];
    RADataObject *notebook2 = [RADataObject dataObjectWithName:@"Notebook 2" children:nil];
    
    RADataObject *computer1 = [RADataObject dataObjectWithName:@"Computer 1"
                                                      children:[NSArray arrayWithObjects:notebook1, notebook2, nil]];
    RADataObject *computer2 = [RADataObject dataObjectWithName:@"Computer 2" children:nil];
    RADataObject *computer3 = [RADataObject dataObjectWithName:@"Computer 3" children:nil];
    
    RADataObject *computer = [RADataObject dataObjectWithName:@"Computers"
                                                     children:[NSArray arrayWithObjects:computer1, computer2, computer3, nil]];
    RADataObject *car = [RADataObject dataObjectWithName:@"Cars" children:nil];
    RADataObject *bike = [RADataObject dataObjectWithName:@"Bikes" children:nil];
    RADataObject *house = [RADataObject dataObjectWithName:@"Houses" children:nil];
    RADataObject *flats = [RADataObject dataObjectWithName:@"Flats" children:nil];
    RADataObject *motorbike = [RADataObject dataObjectWithName:@"Motorbikes" children:nil];
    RADataObject *drinks = [RADataObject dataObjectWithName:@"Drinks" children:nil];
    RADataObject *food = [RADataObject dataObjectWithName:@"Food" children:nil];
    RADataObject *sweets = [RADataObject dataObjectWithName:@"Sweets" children:nil];
    RADataObject *watches = [RADataObject dataObjectWithName:@"Watches" children:nil];
    RADataObject *walls = [RADataObject dataObjectWithName:@"Walls" children:nil];
    
    self.data = [NSArray arrayWithObjects:phone, computer, car, bike, house, flats, motorbike, drinks, food, sweets, watches, walls, nil];
    */
}


@end

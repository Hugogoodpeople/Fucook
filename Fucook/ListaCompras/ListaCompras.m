//
//  ListaCompras.m
//  Fucook
//
//  Created by Hugo Costa on 14/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "ListaCompras.h"
#import "RATreeView.h"

#import "ObjectLista.h"
#import "ListaComprasCell.h"

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
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = NSLocalizedString(@"Things", nil);
   // [self updateNavigationItemButton];
    
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([ListaComprasCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ListaComprasCell class])];
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
    ListaComprasCell *cell = (ListaComprasCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    ListaComprasCell *cell = (ListaComprasCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:YES animated:YES];
}

- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item
{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
    ObjectLista *parent = [self.treeView parentForItem:item];
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
    }
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    ObjectLista *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    ListaComprasCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([ListaComprasCell class])];
    [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    cell.additionButtonTapAction = ^(id sender){
        if (![weakSelf.treeView isCellForItemExpanded:dataObject] || weakSelf.treeView.isEditing) {
            return;
        }
        ObjectLista *newDataObject = [[ObjectLista alloc] initWithName:@"Added value" children:@[]];
        [dataObject addChild:newDataObject];
        [weakSelf.treeView insertItemsAtIndexes:[NSIndexSet indexSetWithIndex:0] inParent:dataObject withAnimation:RATreeViewRowAnimationLeft];
        [weakSelf.treeView reloadRowsForItems:@[dataObject] withRowAnimation:RATreeViewRowAnimationNone];
    };
    
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    ObjectLista *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    ObjectLista *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return data.children[index];
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
    ObjectLista *phone1 = [ObjectLista dataObjectWithName:@"Phone 1" children:nil];
    ObjectLista *phone2 = [ObjectLista dataObjectWithName:@"Phone 2" children:nil];
    ObjectLista *phone3 = [ObjectLista dataObjectWithName:@"Phone 3" children:nil];
    ObjectLista *phone4 = [ObjectLista dataObjectWithName:@"Phone 4" children:nil];
    
    ObjectLista *phone = [ObjectLista dataObjectWithName:@"Phones"
                                                  children:[NSArray arrayWithObjects:phone1, phone2, phone3, phone4, nil]];
    
    ObjectLista *notebook1 = [ObjectLista dataObjectWithName:@"Notebook 1" children:nil];
    ObjectLista *notebook2 = [ObjectLista dataObjectWithName:@"Notebook 2" children:nil];
    
    ObjectLista *computer1 = [ObjectLista dataObjectWithName:@"Computer 1"
                                                      children:[NSArray arrayWithObjects:notebook1, notebook2, nil]];
    ObjectLista *computer2 = [ObjectLista dataObjectWithName:@"Computer 2" children:nil];
    ObjectLista *computer3 = [ObjectLista dataObjectWithName:@"Computer 3" children:nil];
    
    ObjectLista *computer = [ObjectLista dataObjectWithName:@"Computers"
                                                     children:[NSArray arrayWithObjects:computer1, computer2, computer3, nil]];
    ObjectLista *car = [ObjectLista dataObjectWithName:@"Cars" children:nil];
    ObjectLista *bike = [ObjectLista dataObjectWithName:@"Bikes" children:nil];
    ObjectLista *house = [ObjectLista dataObjectWithName:@"Houses" children:nil];
    ObjectLista *flats = [ObjectLista dataObjectWithName:@"Flats" children:nil];
    ObjectLista *motorbike = [ObjectLista dataObjectWithName:@"Motorbikes" children:nil];
    ObjectLista *drinks = [ObjectLista dataObjectWithName:@"Drinks" children:nil];
    ObjectLista *food = [ObjectLista dataObjectWithName:@"Food" children:nil];
    ObjectLista *sweets = [ObjectLista dataObjectWithName:@"Sweets" children:nil];
    ObjectLista *watches = [ObjectLista dataObjectWithName:@"Watches" children:nil];
    ObjectLista *walls = [ObjectLista dataObjectWithName:@"Walls" children:nil];
    
    self.data = [NSArray arrayWithObjects:phone, computer, car, bike, house, flats, motorbike, drinks, food, sweets, watches, walls, nil];

}


@end

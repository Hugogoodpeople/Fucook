//
//  DragableMealPlaner.m
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DragableMealPlaner.h"
#import "MealPlanerCell.h"

@interface DragableMealPlaner ()

@end

@implementation DragableMealPlaner


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Reordering";
    
    /*
     Populate array.
     */
    if (arrayOfItems == nil)
    {
        
        NSUInteger numberOfItems = 20;
        
        arrayOfItems = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
        
        for (NSUInteger i = 0; i < numberOfItems; ++i)
            [arrayOfItems addObject:[NSString stringWithFormat:@"Item #%i", i + 1]];
    }
    
    //[self.tableView setFrame:self.view.frame];
    //[self.tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    NSLog(@"altura da tabela %f largura %f", self.tableView.frame.size.height , self.tableView.frame.size.width);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView flashScrollIndicators];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
     Disable reordering if there's one or zero items.
     For this example, of course, this will always be YES.
     */
    
#warning activar aqui se quiseres voltar atras para a dragable
   // [self setReorderingEnabled:( arrayOfItems.count > 1 )];
    
    return arrayOfItems.count;
}


/*
 // Override to support conditional editing of the table view.
 // This only needs to be implemented if you are going to be returning NO
 // for some items. By default, all items are editable.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return YES if you want the specified item to be editable.
 return YES;
 }
 
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 //add code here for when you hit delete
 }
 }
 */

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"MealPlanerCell";
    
    MealPlanerCell *cell = (MealPlanerCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MealPlanerCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.clipsToBounds = YES;
    // [cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    
    
    
    cell.labelPagina.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, [UIScreen mainScreen].bounds.size.height -180 );
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [cell.viewMovel.layer setMask:_maskingLayer];

    
    [cell setSelected:YES];
    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    cell.delegate = self.delegate;
    
    return cell;
    
}

/*
// should be identical to cell returned in -tableView:cellForRowAtIndexPath:
- (UITableViewCell *)cellIdenticalToCellAtIndexPath:(NSIndexPath *)indexPath forDragTableViewController:(ATSDragToReorderTableViewController *)dragTableViewController {
    
  
    static NSString *simpleTableIdentifier = @"BookCell";
    
    MealPlanerCell *cell = (MealPlanerCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.clipsToBounds = YES;
   // [cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
   // NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    
    
    
    cell.labelPagina.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    
    [cell setSelected:YES];
    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    cell.delegate = self.delegate;
    
    return cell;

    
}
 */

/*
	Required for drag tableview controller
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSString *itemToMove = [arrayOfItems objectAtIndex:fromIndexPath.row];
    [arrayOfItems removeObjectAtIndex:fromIndexPath.row];
    [arrayOfItems insertObject:itemToMove atIndex:toIndexPath.row];
    
}




/*
 #pragma mark -
 #pragma mark Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }
 
 
 #pragma mark -
 #pragma mark Memory management
 
 - (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Relinquish ownership any cached data, images, etc that aren't in use.
 }
 */


@end


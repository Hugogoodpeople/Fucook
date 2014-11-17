//
//  RootViewController.m
//  Reordering
//
//  Created by Daniel Shusta on 12/31/10.
//  Copyright 2010 Acacia Tree Software. All rights reserved.
//

/*
	This is standard UITableViewController stuff. I wrote this first as a UITableViewController and then changed the superclass to ATSDragToReorderTableViewController.
 
	Then made three differences:
		Implemented -tableView:moveRowAtIndexPath:toIndexPath:
		Implemented -cellIdenticalToCellAtIndexPath:forDragTableViewController:
		Disabled reordering if there's only one item in -tableView:numberOfRowsInSection: (more complicated tableViewControllers might need to check for this condition in other places too)
 */


#import "RootViewController.h"
#import "LivroCellTableViewCell.h"
#import "ObjectLivro.h"
#import "UIImage+fixOrientation.h"
#import "FTWCache.h"
#import "NSString+MD5.h"
#import "AppDelegate.h"



@implementation RootViewController
@synthesize arrayOfItems;

NSManagedObject * managedObject;

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
			[arrayOfItems addObject:[ObjectLivro new]];
	}
    
    //[self.tableView setFrame:self.view.frame];
    //[self.tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.tableView.showsVerticalScrollIndicator = YES;
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
	[self setReorderingEnabled:( arrayOfItems.count > 1 )];
	
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
    
    static NSString *simpleTableIdentifier = @"Cell";
    ObjectLivro * livro = [self.arrayOfItems objectAtIndex:indexPath.row];
    
    LivroCellTableViewCell *cell = (LivroCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LivroCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.clipsToBounds = YES;
        [cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
        cell.delegate = self;
        
    }
    
    cell.managedObject = livro.managedObject;
    cell.imageCapa.asynchronous = YES;
    
    cell.labelDescricao.text = livro.descricao;
    cell.labelTitulo.text = livro.titulo;
    
    /*
    FXImageView * imagem = (id)[cell viewWithTag:6];
    if(!imagem.image)
    {
        imagem = [FXImageView new];
        imagem.tag = 6;
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            UIImage *image = [[UIImage imageWithData:[livro.imagem valueForKey:@"imagem"]] fixOrientation];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageCapa.image = image;
            });
        });

    }
     */
    
    NSString *key = [livro.imagem.description MD5Hash];
    NSData *data = [FTWCache objectForKey:key];
    if (data) {
        UIImage *image = [[UIImage imageWithData:[livro.imagem valueForKey:@"imagem"]] fixOrientation];
        cell.imageCapa.image = image;
    } else {
        cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData * data = [livro.imagem valueForKey:@"imagem"];
            [FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageCapa.image = image;
            });
        });
    }
    
    
    //cell.imageCapa.image = livro.imagem;
    
    
    
    
//cell.imageCapa.image = [[UIImage imageWithData:[livro.imagem valueForKey:@"imagem"]] fixOrientation];
    
    
    
    [cell setSelected:YES];
    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    return cell;
    
}
 

// should be identical to cell returned in -tableView:cellForRowAtIndexPath:
- (UITableViewCell *)cellIdenticalToCellAtIndexPath:(NSIndexPath *)indexPath forDragTableViewController:(ATSDragToReorderTableViewController *)dragTableViewController {
    
    /*
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    return cell;
     */
    static NSString *simpleTableIdentifier = @"Cell";
    
    LivroCellTableViewCell *cell = (LivroCellTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LivroCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    [cell setSelected:YES];
    
    return cell;
    
}

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

-(void)editBook:(NSManagedObject *)managedObject
{
    NSLog(@"clicou edit");
    
    if (self.delegate) {
        [self.delegate performSelector:@selector(editBook:) withObject:managedObject];
    }
}


-(void)apagarLivro:(NSManagedObject*)mo
{
    
    managedObject = mo;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to delete this recipe book?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag = 1;
    [alert show];
    
 
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            
            NSManagedObjectContext * context = [AppDelegate sharedAppDelegate].managedObjectContext;
            [context deleteObject:managedObject];
            
            // tenho de actualizar as tabelas
            if (self.delegate) {
                [self.delegate performSelector:@selector(actualizarTudo) withObject:nil ];
            }
            
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
                return;
            }
        }
    }
  
}

@end


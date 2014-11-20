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
#import "Globals.h"




@implementation RootViewController
@synthesize arrayOfItems, imagens;



NSManagedObject * managedObject;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
    }

	self.navigationItem.title = @"Reordering";
	
	/*
		Populate array.
	 
	if (arrayOfItems == nil)
    {
		
		NSUInteger numberOfItems = 20;
		
		arrayOfItems = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
		
		for (NSUInteger i = 0; i < numberOfItems; ++i)
			[arrayOfItems addObject:[ObjectLivro new]];
	}
    */
    
    //[self.tableView setFrame:self.view.frame];
    //[self.tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
   
    
    NSLog(@"altura da tabela %f largura %f", self.tableView.frame.size.height , self.tableView.frame.size.width);
    
    

}

-(void)actualizarImagens
{
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
    }
    
    [self.tableView reloadData];
    
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
        
        //NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
        cell.delegate = self;
        cell.imageCapa.asynchronous = YES;
        
        // vou trocar o sistema todo aqui
        
       // NSString *key = [livro.imagem.description MD5Hash];
       // NSData *data = [FTWCache objectForKey:key];
        if ([imagens objectAtIndex:indexPath.row]!= [NSNull null])
        {
            //UIImage *image = [UIImage imageWithData:data];
            cell.imageCapa.image = [imagens objectAtIndex:indexPath.row];
        }
        else
        {
            //cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData * data = [livro.imagem valueForKey:@"imagem"];
                //[FTWCache setObject:data forKey:key];
                UIImage *image = [UIImage imageWithData:data];
                NSInteger index = indexPath.row;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageCapa.image = image;
                    [imagens replaceObjectAtIndex:index withObject:image];
                });
            });
        }

        
    }
    
    cell.managedObject = livro.managedObject;
    
    
    cell.labelDescricao.text = livro.descricao;
    cell.labelTitulo.text = [livro.titulo uppercaseString];
    
    
    
    [cell setSelected:YES];
    
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
    ObjectLivro * livro = [self.arrayOfItems objectAtIndex:indexPath.row];
    
    LivroCellTableViewCell *cell = (LivroCellTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
        cell.imageCapa.asynchronous = YES;
        
        // vou trocar o sistema todo aqui
        
        // NSString *key = [livro.imagem.description MD5Hash];
        // NSData *data = [FTWCache objectForKey:key];
        if ([imagens objectAtIndex:indexPath.row]!= [NSNull null])
        {
            //UIImage *image = [UIImage imageWithData:data];
            cell.imageCapa.image = [imagens objectAtIndex:indexPath.row];
        }
        else
        {
            //cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData * data = [livro.imagem valueForKey:@"imagem"];
                //[FTWCache setObject:data forKey:key];
                UIImage *image = [UIImage imageWithData:data];
                NSInteger index = indexPath.row;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageCapa.image = image;
                    [imagens replaceObjectAtIndex:index withObject:image];
                });
            });
        }
    }
    
    cell.managedObject = livro.managedObject;
    
    
    cell.labelDescricao.text = livro.descricao;
    cell.labelTitulo.text = [livro.titulo uppercaseString];
    
    
    
    [cell setSelected:YES];
    
    return cell;

    
}

/*
	Required for drag tableview controller
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    // esta merda trocas as receitas todas dentro dos livros
    NSInteger fromInd = fromIndexPath.row;
    NSInteger toInd   = toIndexPath.row;
    
    // tenho de trocar no array o cenas tbm para ele nao baralhar
    // tenho de por aqui a salvar no core data as alterações do drag and drop
    ObjectLivro * livro1 = [self.arrayOfItems objectAtIndex:fromInd];
    ObjectLivro * livro2 = [self.arrayOfItems objectAtIndex:toInd];
   

    
    NSManagedObject * objectToMove1 = livro1.managedObject;
    NSManagedObject * objectToMove2 = livro2.managedObject;
    NSManagedObject * temp1 = [livro1.managedObject valueForKey:@"contem_receitas"];
    NSManagedObject * temp2 = [livro2.managedObject valueForKey:@"contem_receitas"];
    
    
    [objectToMove1 setNilValueForKey:@"contem_receitas"];
    [objectToMove2 setNilValueForKey:@"contem_receitas"];
    
    
    // esta parte qui é que está mal por algum motivo que nao sei qual
    [objectToMove1 setValue:livro2.titulo forKey:@"titulo"];
    [objectToMove1 setValue:livro2.descricao forKey:@"descricao"];
    [objectToMove1 setValue:livro2.imagem forKey:@"contem_imagem"];
    [objectToMove1 setValue:temp2 forKey:@"contem_receitas"];
    // tenho de mover tambem o resto senao nao funcionam direito as receitas
    
    
    [objectToMove2 setValue:livro1.titulo forKey:@"titulo"];
    [objectToMove2 setValue:livro1.descricao forKey:@"descricao"];
    [objectToMove2 setValue:livro1.imagem forKey:@"contem_imagem"];
    [objectToMove2 setValue:temp1 forKey:@"contem_receitas"];
    
    
    
    // para ir buscar os dados prestendidos a base de dados
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Livros" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't replace! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    // este é o array com os livros
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    

    
    
    NSLog(@"************************************ Livros reordenados ************************************");
    
    for (NSManagedObject *pedido in fetchedObjects)
    {
        
        
        NSLog(@"titulo: %@", [pedido valueForKey:@"titulo"]);
        //NSLog(@"descrição: %@", [pedido valueForKey:@"descricao"]);
        
    }

    
    
    // este metudo é burro e dize sempre de onde troquei originalmente
    // tenho de ver se move para a frente ou para traz e adicionar ou remover 1 conforme a direcção
  
    
    // em vez de remove e depois insert vou fazer o replace
    NSString *itemToMove = [arrayOfItems objectAtIndex:fromIndexPath.row];
    [self.arrayOfItems removeObjectAtIndex:fromIndexPath.row];
    [self.arrayOfItems insertObject:itemToMove atIndex:toIndexPath.row];
    
    
    
    
    // tenho de trocar o indice das imagens aqui
    UIImage * tempImage1 = [imagens objectAtIndex:fromIndexPath.row];
    [imagens removeObjectAtIndex:fromIndexPath.row];
    [imagens insertObject:tempImage1 atIndex:toIndexPath.row];
    
    
    

    if (self.delegate) {
        [self.delegate performSelector:@selector(actualizarTudo) withObject:nil ];
    }
    
    
   

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
    
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
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
            
            imagens = [[NSMutableArray alloc] init];
            
            for (NSInteger i = 0; i < 1000; ++i)
            {
                [imagens addObject:[NSNull null]];
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


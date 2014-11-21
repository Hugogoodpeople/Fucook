//
//  DragableTableReceitas.m
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DragableTableReceitas.h"
#import "BookCell.h"
#import "ObjectReceita.h"


@interface DragableTableReceitas ()
{
    NSManagedObjectContext * context;
}

@end

@implementation DragableTableReceitas

@synthesize arrayOfItems, imagens;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Reordering";
    
    context = [AppDelegate sharedAppDelegate].managedObjectContext;
    
    /*
     Populate array.
     */
    if (arrayOfItems == nil)
    {
        arrayOfItems = [[NSMutableArray alloc] init];
    }
    
    [self actualizarImagens];
    
    //[self.tableView setFrame:self.view.frame];
    //[self.tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.tableView.showsVerticalScrollIndicator = NO;
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
    
    //[self.tableView reloadData];
    
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
#warning descomentar para poder ter dragable
    //[self setReorderingEnabled:( arrayOfItems.count > 1 )];
    
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
    
    static NSString *simpleTableIdentifier = @"BookCell";
    
    
    ObjectReceita * receita = [self.arrayOfItems objectAtIndex:indexPath.row];
    
    BookCell *cell = (BookCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.clipsToBounds = YES;
        //[cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
       // NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    
        
        // vou trocar o sistema todo aqui
        
        // NSString *key = [livro.imagem.description MD5Hash];
        // NSData *data = [FTWCache objectForKey:key];
        if ( [imagens objectAtIndex:indexPath.row]!= [NSNull null] )
        {
            //UIImage *image = [UIImage imageWithData:data];
            cell.imageCapa.image = [imagens objectAtIndex:indexPath.row];
        }
        else
        {
            //cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData * data = [receita.imagem valueForKey:@"imagem"];
                //[FTWCache setObject:data forKey:key];
                UIImage *image = [UIImage imageWithData:data];
                NSInteger index = indexPath.row;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageCapa.image = image;
                    if (image)
                        [imagens replaceObjectAtIndex:index withObject:image];
                });
            });
        }

    }
    
    cell.labelPagina.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.managedObject = receita.managedObject;
    
    [cell setSelected:YES];
    
    float altura = [self calcularAltura];
    
    
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, altura);
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [cell.viewMovel.layer setMask:_maskingLayer];
    
   
    cell.labelTitulo.text = receita.nome;
    cell.labelTempo.text = receita.tempo;
    //[cell.imageCapa setImage:[UIImage imageNamed:@"imgsample001.jpg"]];

    //cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
    
    cell.delegate = self.delegate;
    
    return cell;
    
}

-(float)calcularAltura
{
    int alturaEcra = [UIScreen mainScreen].bounds.size.height;
    int devolver;
    
    if (alturaEcra == 480)
    {
        devolver = 295;
    }else if (alturaEcra == 568)
    {
        devolver = 370;
    }else if (alturaEcra == 667)
    {
        devolver = 450;
    }
    else if (alturaEcra == 736)
    {
        devolver = 510;
    }
    
    return devolver;
}


// should be identical to cell returned in -tableView:cellForRowAtIndexPath:
- (UITableViewCell *)cellIdenticalToCellAtIndexPath:(NSIndexPath *)indexPath forDragTableViewController:(ATSDragToReorderTableViewController *)dragTableViewController {
    
    /*
     UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
     cell.textLabel.text = [arrayOfItems objectAtIndex:indexPath.row];
     
     return cell;
     */
    static NSString *simpleTableIdentifier = @"BookCell";
    
    
    ObjectReceita * receita = [self.arrayOfItems objectAtIndex:indexPath.row];
    
    BookCell *cell = (BookCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.clipsToBounds = YES;
    //[cell.contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
   // NSLog(@"altura da celula %f largura %f", cell.contentView.frame.size.height , cell.contentView.frame.size.width);
    
    
    
    cell.labelPagina.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    
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
            NSData * data = [receita.imagem valueForKey:@"imagem"];
            //[FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            NSInteger index = indexPath.row;
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageCapa.image = image;
                [imagens replaceObjectAtIndex:index withObject:image];
            });
        });
    }

    cell.labelTitulo.text = receita.nome;
    cell.labelTempo.text = receita.tempo;
    
    //[cell setSelected:YES];
    
    
    float altura = [self calcularAltura];
    UIImage *_maskingImage = [UIImage imageNamed:@"mascara_transparente.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, altura);
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [cell.viewMovel.layer setMask:_maskingLayer];

    
    
    
    return cell;
}

/*
	Required for drag tableview controller
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSInteger fromInd = fromIndexPath.row;
    NSInteger toInd   = toIndexPath.row;
    
    // tenho de trocar no array o cenas tbm para ele nao baralhar
    // tenho de por aqui a salvar no core data as alterações do drag and drop
    ObjectReceita * receita1 = [self.arrayOfItems objectAtIndex:fromInd];
    ObjectReceita * receita2 = [self.arrayOfItems objectAtIndex:toInd];
    
 
    NSManagedObject * objectToMove1 = receita1.managedObject;
    NSManagedObject * objectToMove2 = receita2.managedObject;
    
    // tenho de fazer as trocas das relações aqui
    
    
    // esta parte qui é que está mal por algum motivo que nao sei qual
    [objectToMove1 setValue:receita2.nome forKey:@"nome"];
    //[objectToMove1 setValue:livro2.descricao forKey:@"descricao"];
    [objectToMove1 setValue:receita2.imagem forKey:@"contem_imagem"];
    //[objectToMove1 setValue:[livro2.managedObject valueForKey:@"contem_receitas"] forKey:@"contem_receitas"];
    // tenho de mover tambem o resto senao nao funcionam direito as receitas
    
    
    [objectToMove2 setValue:receita1.nome forKey:@"nome"];
    //[objectToMove2 setValue:livro1.descricao forKey:@"descricao"];
    [objectToMove2 setValue:receita1.imagem forKey:@"contem_imagem"];
    //[objectToMove2 setValue:[livro1.managedObject valueForKey:@"contem_receitas"] forKey:@"contem_receitas"];
    
    
    
    // para ir buscar os dados prestendidos a base de dados
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't replace! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    NSSet * receitas = [self.livro.managedObject valueForKey:@"contem_receitas"];
    for (NSManagedObject * receita in receitas) {
        NSLog(@"************************** Receita ***************************");
        NSLog(@"Nome receita: %@", [receita valueForKey:@"nome"]);
        
    }
    
    // este metodo é burro e dize sempre de onde troquei originalmente
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


@end


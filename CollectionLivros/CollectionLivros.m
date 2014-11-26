//
//  CollectionLivros.m
//  Fucook
//
//  Created by Hugo Costa on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "CollectionLivros.h"
#import "CollectionLivroCellCollectionViewCell.h"
#import "ObjectLivro.h"
#import "NSString+MD5.h"
#import "FTWCache.h"
#import "UIImage+fixOrientation.h"


@interface CollectionLivros ()

@end

@implementation CollectionLivros

@synthesize arrayOfItems, imagens;

static NSString * const reuseIdentifier = @"CollectionLivroCellCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[CollectionLivroCellCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
    }

    
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];

    
    // Do any additional setup after loading the view.

}




-(void)actualizarImagens
{
    imagens = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 1000; ++i)
    {
        [imagens addObject:[NSNull null]];
    }
    
    [self.collectionView reloadData];

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

#pragma mark <UICollectionViewDataSource>



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    int valor = (int) (arrayOfItems.count +1 )/2;
    return valor;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    int valor =(arrayOfItems.count/(section + 1)) >= 2? 2: 1;
   // int valor = 3;
    
   return valor;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = reuseIdentifier;
    
    CollectionLivroCellCollectionViewCell *cell = (CollectionLivroCellCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    ObjectLivro * livro = [arrayOfItems objectAtIndex:(indexPath.row+ (indexPath.section * 2))];
    
    
    //cell.imagemCapa.image = livro.imagem;
    cell.labelTitulo.text = livro.titulo;
    cell.labelDescricao.text = livro.descricao;
    
    //cell.imagemCapa.asynchronous = YES;
    
    // vou trocar o sistema todo aqui
    
    // NSString *key = [livro.imagem.description MD5Hash];
    // NSData *data = [FTWCache objectForKey:key];
    if ([imagens objectAtIndex:indexPath.row +(indexPath.section * 2)]!= [NSNull null])
    {
        //UIImage *image = [UIImage imageWithData:data];
        cell.imagemCapa.image = [imagens objectAtIndex:indexPath.row +(indexPath.section * 2) ];
    }
    else
    {
        //cell.imageCapa.image = [UIImage imageNamed:@"icn_default"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData * data = [livro.imagem valueForKey:@"imagem"];
            //[FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            NSInteger index =indexPath.row +(indexPath.section * 2);
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imagemCapa.image = image;
                [imagens replaceObjectAtIndex:index withObject:image];
            });
        });
    
    }

    return cell;
}

#pragma mark <UICollectionViewDelegate>

// para quando é descelecionado
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deDelected %ld", (long)indexPath.row);
    if (self.delegate) {
//        [self.delegate performSelector:@selector(abrirLivro) withObject:nil];
    }
}

// para quando é selecionado
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld", (long)indexPath.row);
    if (self.delegate)
    {
        ObjectLivro * livro = [self.arrayOfItems objectAtIndex:indexPath.row + (indexPath.section*2)];
        
        [self.delegate performSelector:@selector(abrirLivro:) withObject:livro];
    }
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

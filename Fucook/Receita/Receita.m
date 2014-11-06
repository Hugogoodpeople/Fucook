//
//  Receita.m
//  Fucook
//
//  Created by Rundlr on 05/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "CellReceita.h"
#import "HeaderReceita.h"
#import "Receita.h"

@interface Receita (){
     HeaderReceita * headerFinal;
    
}

@property (strong, readonly, nonatomic) NSMutableArray *cards;

@end

@implementation Receita

@synthesize cards = _cards;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set to NO to prevent a small number
    // of cards from filling the entire
    // view height evenly and only show
    // their -topReveal amount
    //
    self.stackedLayout.fillHeight = NO;
    
    // Set to NO to prevent a small number
    // of cards from being scrollable and
    // bounce
    //
    self.stackedLayout.alwaysBounce = YES;
    
    // Set to NO to prevent unexposed
    // items at top and bottom from
    // being selectable
    //
    self.unexposedItemsAreSelectable = YES;
    
    if (self.doubleTapToClose) {
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        
        recognizer.delaysTouchesBegan = YES;
        recognizer.numberOfTapsRequired = 2;
        
        [self.collectionView addGestureRecognizer:recognizer];
    }
    
   // headerFinal = [HeaderReceita alloc];
    //[headerFinal.view setFrame:CGRectMake(0, 0, 320, headerFinal.view.frame.size.height )];

    
  //  [self.collectionView addSubview: headerFinal.view];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - Accessors

- (NSMutableArray *)cards {
    
    if (_cards == nil) {
        
        NSArray *cards = @[ @{ @"name" : @"Ingredients", @"color" : [UIColor redColor] },
                            @{ @"name" : @"Directions", @"color" : [UIColor greenColor] },
                            @{ @"name" : @"Notes", @"color" : [UIColor yellowColor] },
                            @{ @"name" : @"Nutricion", @"color" : [UIColor blueColor] }];
        
        _cards = [NSMutableArray arrayWithArray:cards];
    }
    
    return _cards;
}

#pragma mark - Actions

- (IBAction)handleDoubleTap:(UITapGestureRecognizer *)recognizer {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CollectionViewDataSource protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.cards.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellReceita *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellReceita" forIndexPath:indexPath];
    NSDictionary *card = self.cards[indexPath.item];
    
    cell.title = card[@"name"];
    cell.color = card[@"color"];
    
    return cell;
}




#pragma mark - Overloaded methods

- (void)moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    // Update data source when moving cards around
    //
    NSDictionary *card = self.cards[fromIndexPath.item];
    
    [self.cards removeObjectAtIndex:fromIndexPath.item];
    [self.cards insertObject:card atIndex:toIndexPath.item];
}

@end

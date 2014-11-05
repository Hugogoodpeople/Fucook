//
//  TGLViewController.m
//  TGLStackedViewExample
//
//  Created by Tim Gleue on 07.04.14.
//  Copyright (c) 2014 Tim Gleue ( http://gleue-interactive.com )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "TGLViewController.h"
#import "TGLCollectionViewCell.h"
#import "HeaderReceita.h"



@interface TGLViewController (){
    HeaderReceita * headerFinal;
}

@property (strong, readonly, nonatomic) NSMutableArray *cards;

@end

@implementation TGLViewController

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
    
    headerFinal = [HeaderReceita alloc];
    [headerFinal.view setFrame:CGRectMake(0, 0, 320, headerFinal.view.frame.size.height )];
    //headerHeight = headerFinal.view.frame.size.height;

    [self.collectionView addSubview: headerFinal.view];

    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
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
    
    TGLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
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

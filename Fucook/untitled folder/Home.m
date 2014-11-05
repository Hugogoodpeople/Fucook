//
//  Home.m
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Home.h"
#import "Books.h"
#import "LivrosView.h"
#import "Constant.h"

@interface Home ()


@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *itemsTop;
@property (nonatomic, strong) NSMutableArray *itemsBottom;

@end

@implementation Home

@synthesize carouselTop;
@synthesize wrap;
@synthesize itemsTop, itemsBottom;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [carouselTop setTag:CAROUSEL_TOP];
    carouselTop.ignorePerpendicularSwipes = NO;
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    //[button addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsearch"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    UIButton * buttonadd = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    //[buttonadd addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [buttonadd setImage:[UIImage imageNamed:@"btnaddbook.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonadd = [[UIBarButtonItem alloc] initWithCustomView:buttonadd];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    //self.navigationItem.rightBarButtonItem = anotherButtonadd;
    
    UIButton * buttonmoc = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    [buttonmoc addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [buttonmoc setImage:[UIImage imageNamed:@"btnmosaic.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonmoc = [[UIBarButtonItem alloc] initWithCustomView:buttonmoc];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    //self.navigationItem.rightBarButtonItem = anotherButtonmoc;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButtonadd, anotherButtonmoc, nil]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
    //set up data
    wrap = NO;
    
    self.itemsTop = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [itemsTop addObject:@(i)];
    }
    
    self.itemsBottom = [NSMutableArray array];
    for (int i = 20; i < 30; i++)
    {
        [itemsBottom addObject:@(i)];
    }
}


// aqui tenho de de fazer replace dentro do mesmo cenas
- (void)moveItemToTop:(NSInteger)itemIndex{
    
    NSInteger index = MAX(0, carouselTop.currentItemIndex);
    
    if (!carouselTop.isCardInsertedLeft && itemsTop.count < index) {
        index += 1;
    }
    
    //item addressed
    NSInteger itemAddressed = [[self.itemsTop objectAtIndex:itemIndex] integerValue];
    
  
        //NSInteger index = carouselBottom.currentItemIndex;
        [itemsTop removeObjectAtIndex:itemIndex];
        [carouselTop removeItemAtIndex:itemIndex animated:YES];
    
    //add to top
    [itemsTop insertObject:@(itemAddressed) atIndex:index];
    [carouselTop insertItemAtIndex:index animated:YES];
}


/*
- (void)moveItemToBottom:(NSInteger)itemIndex{
    
    NSInteger index = MAX(0, carouselBottom.currentItemIndex);
    
    if (!carouselTop.isCardInsertedLeft && [self.itemsBottom count] > 0) {
        index += 1;
    }
    
    //item addressed
    NSInteger itemAddressed = [[self.itemsTop objectAtIndex:itemIndex] integerValue];
    
    //remove from top
    if (carouselTop.numberOfItems > 0)
    {
        //NSInteger index = carouselTop.currentItemIndex;
        [itemsTop removeObjectAtIndex:itemIndex];
        [carouselTop removeItemAtIndex:itemIndex animated:YES];
    }
    
    //add to bottom
    [itemsBottom insertObject:@(itemAddressed) atIndex:index];
    [carouselBottom insertItemAtIndex:index animated:YES];
}
*/
 
#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
        return [itemsTop count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (carousel == carouselTop) {
        return [self getCardViewForItemAtIndex:index reusingView:view itemsArray:self.itemsTop];
    }
    else{
        return [self getCardViewForItemAtIndex:index reusingView:view itemsArray:self.itemsBottom];
    }
}

- (UIView *)getCardViewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view itemsArray:(NSMutableArray*)items{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 230.0f)];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        
        [view.layer setCornerRadius:2];
        [view.layer setShadowColor:[UIColor blackColor].CGColor];
        [view.layer setShadowOpacity:0.8];
        [view.layer setShadowOffset:CGSizeMake(-2, -2)];
        
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [items[index] stringValue];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (carousel == carouselTop) {
        return [self getPlaceHolderViewAtIndex:index reusingView:view];
    }
    else{
        return [self getPlaceHolderViewAtIndex:index reusingView:view];
    }
}

- (UIView *)getPlaceHolderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 230.0f)];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    //label.text = (index == 0)? @"[": @"]";
    
    return view;
}


- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionArc:
        {
            return 2 * M_PI * 0.119929;
        }
        case iCarouselOptionRadius:
        {
            return value * 1.557364;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            if (_carousel == carouselTop) {
                return 1.052855;
            }
            else
            {
                return value * 0.624498;
            }
            
        }
        case iCarouselOptionFadeMax:
        {
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

/*- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
 {
 if (carousel == carouselTop) {
 NSNumber *item = (self.itemsTop)[index];
 NSLog(@"Tapped view number: %@", item);
 [self moveItemToBottom:index];
 }
 else{
 NSNumber *item = (self.itemsBottom)[index];
 NSLog(@"Tapped view number: %@", item);
 [self moveItemToTop:index];
 }
 }*/

- (void)carousel:(iCarousel *)carousel itemMoveWithIndex:(NSInteger)index{
    /*
    if (carousel.tag == CAROUSEL_TOP) {
        [self moveItemToBottom:index];
    }
    else
     */
    {
        [self moveItemToTop:index];
    }
}

-(void)arrastou:(iCarousel *)carousel
{
    NSLog(@"fez scroll para %hhd", carouselTop.isCardInsertedLeft);
}

@end


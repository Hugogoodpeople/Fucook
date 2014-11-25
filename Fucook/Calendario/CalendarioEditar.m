//
//  CalendarioEditarViewController.m
//  Fucook
//
//  Created by Hugo Costa on 25/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "CalendarioEditar.h"

@interface CalendarioEditar ()

@property VRGCalendarView *calendar;
@end

@implementation CalendarioEditar
@synthesize calendar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    
    calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.container addSubview:calendar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    NSLog(@"mudou mes");
   
}


-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);

}

@end

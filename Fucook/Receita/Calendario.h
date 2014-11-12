//
//  Calendario.h
//  Fucook
//
//  Created by Hugo Costa on 12/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"


@interface Calendario : UIViewController <VRGCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *container;

@end

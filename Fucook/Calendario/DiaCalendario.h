//
//  DiaCalendario.h
//  Fucook
//
//  Created by Hugo Costa on 13/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaCalendario : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lableDia;
@property (weak, nonatomic) IBOutlet UILabel *labelDiaSemana;
@property (weak, nonatomic) IBOutlet UIImageView *ImgSelected;


@property NSString * diaSemana;
@property NSString * dia;


@end

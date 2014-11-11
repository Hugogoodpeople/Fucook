//
//  HeaderNewReceita.h
//  Fucook
//
//  Created by Rundlr on 07/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderNewReceita : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,assign) id delegate;
- (IBAction)btFoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

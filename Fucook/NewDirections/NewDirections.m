//
//  NewDirections.m
//  Fucook
//
//  Created by Rundlr on 10/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "NewDirections.h"

@interface NewDirections (){
     BOOL PickerAberto;
}

@property (nonatomic, weak) IBOutlet UIToolbar *toolBar;
@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *takePictureButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, weak) NSTimer *cameraTimer;
@property (nonatomic) NSMutableArray *capturedImages;

@end

@implementation NewDirections

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //[button addTarget:self action:@selector(receita:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"btnsave2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    UIButton * buttonback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [buttonback addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [buttonback setImage:[UIImage imageNamed:@"btleft2"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButtonback = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    self.navigationItem.leftBarButtonItem = anotherButtonback;
    
    self.navigationItem.title = @"Directions";
    
    [self.scrollDir setContentSize:CGSizeMake(self.view.frame.size.width, self.viewDown.frame.origin.y+self.viewDown.frame.size.height+5)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.capturedImages = [[NSMutableArray alloc] init];
    
    self.textDesc.delegate=self;
    self.textDesc.tag=1;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(PickerAberto==1){
        [self btAbrir:self];
    }
        CGPoint scrollPoint = CGPointMake(0, 300);
        [self.scrollDir setContentOffset:scrollPoint animated:YES];

}


-(void)handleSingleTap
{
    [self.textDesc resignFirstResponder];
    CGPoint scrollPoint = CGPointMake(0, 0);    
    [self.scrollDir setContentOffset:scrollPoint animated:YES];
}




- (IBAction)btFoto:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Choose from library",
                            @"Take photo",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"library");
                    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                case 1:
                    NSLog(@"photo");
                    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
                    //if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    //[self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
                    //}
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imgView.isAnimating)
    {
        [self.imgView stopAnimating];
    }
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = NO;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        self.overlayView = nil;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


#pragma mark - Toolbar actions

- (IBAction)done:(id)sender
{
    // Dismiss the camera.
    if ([self.cameraTimer isValid])
    {
        [self.cameraTimer invalidate];
    }
    [self finishAndUpdate];
}


- (IBAction)takePhoto:(id)sender
{
    [self.imagePickerController takePicture];
}


- (IBAction)delayedTakePhoto:(id)sender
{
    // These controls can't be used until the photo has been taken
    self.doneButton.enabled = NO;
    self.takePictureButton.enabled = NO;
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    NSTimer *cameraTimer = [[NSTimer alloc] initWithFireDate:fireDate interval:1.0 target:self selector:@selector(timedPhotoFire:) userInfo:nil repeats:NO];
    
    [[NSRunLoop mainRunLoop] addTimer:cameraTimer forMode:NSDefaultRunLoopMode];
    self.cameraTimer = cameraTimer;
}


- (IBAction)startTakingPicturesAtIntervals:(id)sender
{
    /*
     Start the timer to take a photo every 1.5 seconds.
     
     CAUTION: for the purpose of this sample, we will continue to take pictures indefinitely.
     Be aware we will run out of memory quickly.  You must decide the proper threshold number of photos allowed to take from the camera.
     One solution to avoid memory constraints is to save each taken photo to disk rather than keeping all of them in memory.
     In low memory situations sometimes our "didReceiveMemoryWarning" method will be called in which case we can recover some memory and keep the app running.
     */
    
    
    self.doneButton.enabled = NO;
    self.takePictureButton.enabled = NO;
    
    self.cameraTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timedPhotoFire:) userInfo:nil repeats:YES];
    [self.cameraTimer fire]; // Start taking pictures right away.
}


- (IBAction)stopTakingPicturesAtIntervals:(id)sender
{
    // Stop and reset the timer.
    [self.cameraTimer invalidate];
    self.cameraTimer = nil;
    
    [self finishAndUpdate];
}


- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // Camera took a single picture.
            [self.imgView setImage:[self.capturedImages objectAtIndex:0]];
        }
        else
        {
            // Camera took multiple pictures; use the list of images for animation.
            self.imgView.animationImages = self.capturedImages;
            self.imgView.animationDuration = 5.0;    // Show each captured photo for 5 seconds.
            self.imgView.animationRepeatCount = 0;   // Animate forever (show all photos).
            [self.imgView startAnimating];
        }
        
        // To be ready to start again, clear the captured images array.
        [self.capturedImages removeAllObjects];
    }
    
    self.imagePickerController = nil;
}


#pragma mark - Timer

// Called by the timer to take a picture.
- (void)timedPhotoFire:(NSTimer *)timer
{
    [self.imagePickerController takePicture];
}


#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.capturedImages addObject:image];
    
    if ([self.cameraTimer isValid])
    {
        return;
    }
    
    [self finishAndUpdate];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}




-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // não precisa fazer nada aqui mas convem ter este metodo implementado
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld min",(long)row+1];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    return textView.text.length + (text.length - range.length) <= 2000;

}



- (IBAction)btAbrir:(id)sender {
    NSLog(@"%u",PickerAberto);
    if(PickerAberto){

        [UIView animateWithDuration:0.5 animations:^{
            [self.viewDown setFrame:CGRectMake(0,  self.viewImagem.frame.size.height+self.viewLabel1.frame.size.height+self.viewLabel2.frame.size.height+65, self.viewDown.frame.size.width,self.viewDown.frame.size.height)];
        }];
        [self.scrollDir setContentSize:CGSizeMake(self.view.frame.size.width, 680)];
        PickerAberto=0;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.viewDown setFrame:CGRectMake(0, self.viewImagem.frame.size.height+self.viewLabel1.frame.size.height+self.viewLabel2.frame.size.height+self.viewPicker.frame.size.height+65, self.viewDown.frame.size.width,self.viewDown.frame.size.height)];
        }];
        [self.scrollDir setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
        PickerAberto=1;
    }
    
}
- (IBAction)btDoneTime:(id)sender {
    //long d = [self.pickerView selectedRowInComponent:0];
    self.labelTime.text = [NSString stringWithFormat:@"%ld",(long)[self.pickerView selectedRowInComponent:0]+1];
    [self btAbrir:self];
}
@end

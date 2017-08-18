//
//  Report2ViewController.m
//  MyNBC
//
//  Created by Kevin White on 26/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report2ViewController.h"
#import "Report3ViewController.h"
#import "Report4ViewController.h"

@implementation Report2ViewController
@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Include a picture?";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){//Three buttons
        if (screenBounds.size.height == 568) // 4 inch
        {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                [buttonTakePhoto setCenter:CGPointMake(160,120)];
                [buttonUsePhoto setCenter:CGPointMake(160,220)];
                [buttonNoPhoto setCenter:CGPointMake(160,320)];
            }else{
                [buttonTakePhoto setCenter:CGPointMake(160,120)];
                [buttonUsePhoto setCenter:CGPointMake(160,220)];
                [buttonNoPhoto setCenter:CGPointMake(160,320)];
            }
        }
        else // 3.5 inch
        {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                [buttonTakePhoto setCenter:CGPointMake(160,80)];
                [buttonUsePhoto setCenter:CGPointMake(160,180)];
                [buttonNoPhoto setCenter:CGPointMake(160,280)];
            }
        }
    }else{//Two Buttons
        [buttonTakePhoto setHidden:TRUE];
        if (screenBounds.size.height == 568) // 4 inch
        {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                [buttonTakePhoto setCenter:CGPointMake(160,140)];
                [buttonUsePhoto setCenter:CGPointMake(160,240)];
                [buttonNoPhoto setCenter:CGPointMake(160,340)];
            }
        }
        else // 3.5 inch
        {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                [buttonTakePhoto setCenter:CGPointMake(160,80)];
                [buttonUsePhoto setCenter:CGPointMake(160,180)];
                [buttonNoPhoto setCenter:CGPointMake(160,280)];
            }else{
                [buttonTakePhoto setCenter:CGPointMake(160,40)];
                [buttonUsePhoto setCenter:CGPointMake(160,140)];
                [buttonNoPhoto setCenter:CGPointMake(160,240)];
            }
        }
        
    }

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        buttonTakePhoto.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
        [buttonTakePhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTakePhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonTakePhoto layer] setCornerRadius:8.0f];
        [[buttonTakePhoto layer] setMasksToBounds:YES];

        buttonUsePhoto.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
        [buttonUsePhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonUsePhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonUsePhoto layer] setCornerRadius:8.0f];
        [[buttonUsePhoto layer] setMasksToBounds:YES];
        
        buttonNoPhoto.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
        [buttonNoPhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonNoPhoto setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonNoPhoto layer] setCornerRadius:8.0f];
        [[buttonNoPhoto layer] setMasksToBounds:YES];

    }else{
        [[buttonTakePhoto layer] setCornerRadius:8.0f];
        [[buttonTakePhoto layer] setMasksToBounds:YES];
        [[buttonTakePhoto layer] setBorderWidth:1.0f];
        [[buttonTakePhoto layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                     green:30/255.0
                                                                      blue:72/255.0
                                                                     alpha:1.0] CGColor]];
        
        [[buttonUsePhoto layer] setCornerRadius:8.0f];
        [[buttonUsePhoto layer] setMasksToBounds:YES];
        [[buttonUsePhoto layer] setBorderWidth:1.0f];
        [[buttonUsePhoto layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                    green:30/255.0
                                                                     blue:72/255.0
                                                                    alpha:1.0] CGColor]];
        
        [[buttonNoPhoto layer] setCornerRadius:8.0f];
        [[buttonNoPhoto layer] setMasksToBounds:YES];
        [[buttonNoPhoto layer] setBorderWidth:1.0f];
        [[buttonNoPhoto layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                   green:30/255.0
                                                                    blue:72/255.0
                                                                   alpha:1.0] CGColor]];
    }


    

    
    self.imagePicker = [[[UIImagePickerController alloc] init]autorelease];
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.delegate = self;
    
    usingCamera=false;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)takePhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    usingCamera=true;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setBool:true forKey:@"UseImage"];    
    [defaults synchronize];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.navigationBar.tintColor = [UIColor colorWithRed:170/255.0 green:30/255.0 blue:72/255.0 alpha:1.0];
    //[self presentModalViewController:self.imagePicker animated:YES];
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (IBAction)usePhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    usingCamera=false;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setBool:true forKey:@"UseImage"];    
    [defaults synchronize]; 
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.navigationBar.tintColor = [UIColor colorWithRed:170/255.0 green:30/255.0 blue:72/255.0 alpha:1.0];
    //[self presentModalViewController:self.imagePicker animated:YES];
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (IBAction)noPhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setBool:false forKey:@"UseImage"];    
    [defaults synchronize]; 
    Report4ViewController *vcReport4 = [[Report4ViewController alloc] initWithNibName:@"Report4ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport4 animated:YES];
    [vcReport4 release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Test");
    }];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    [defaults setObject:UIImageJPEGRepresentation([self scaleAndRotateImage:img],1) forKey:@"ImageData"];  
    [defaults synchronize];
    if(usingCamera){
       Report4ViewController *vcReport4 = [[Report4ViewController alloc] initWithNibName:@"Report4ViewController" bundle:nil];
       UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
       self.navigationItem.backBarButtonItem = backButton;
       [backButton release];
       [self.navigationController pushViewController:vcReport4 animated:YES];
       [vcReport4 release];
    }else{
        Report3ViewController *vcReport3 = [[Report3ViewController alloc] initWithNibName:@"Report3ViewController" bundle:nil];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        [self.navigationController pushViewController:vcReport3 animated:YES];
        [vcReport3 release];        
    }
}

- (UIImage *) scaleAndRotateImage:(UIImage *)image{
    int kMaxResolution = 500;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
            }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
            }
        }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
            case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
            case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
            case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
            case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
            case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
             bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
            case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
           transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
            case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
             transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
            default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
        }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
        }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
        }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


@end

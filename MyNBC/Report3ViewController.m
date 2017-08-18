//
//  Report3ViewController.m
//  MyNBC
//
//  Created by Kevin White on 26/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report3ViewController.h"
#import "Report4ViewController.h"

@implementation Report3ViewController
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
    self.navigationItem.title=@"This picture?";  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSData * imageData = [defaults objectForKey:@"ImageData"];
    image.image=[UIImage imageWithData:imageData];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [image setCenter:CGPointMake(162,195)];
            [usebutton setCenter:CGPointMake(160,418)];
        }else{
            [image setCenter:CGPointMake(162,200)];
            [usebutton setCenter:CGPointMake(160,418)];       }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [image setCenter:CGPointMake(162,155)];
            [usebutton setCenter:CGPointMake(160,330)];
        }
    }

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        usebutton.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
        [usebutton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [usebutton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[usebutton layer] setCornerRadius:8.0f];
        [[usebutton layer] setMasksToBounds:YES];
    }else{
        
        [[usebutton layer] setCornerRadius:8.0f];
        [[usebutton layer] setMasksToBounds:YES];
        [[usebutton layer] setBorderWidth:1.0f];
        [[usebutton layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                               green:30/255.0
                                                                blue:72/255.0
                                                               alpha:1.0] CGColor]];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)usePhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    Report4ViewController *vcReport4 = [[Report4ViewController alloc] initWithNibName:@"Report4ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport4 animated:YES];
    [vcReport4 release];
}

- (IBAction)selectPhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
}


@end

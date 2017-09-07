//
//  ServicesMenuViewController.m
//  MyNBC
//
//  Created by Kevin White on 16/05/2012.
//  Copyright (c) 2012 Northampton Borough Council. All rights reserved.
//

#import "ServicesMenuViewController.h"
#import "MyDetailsViewController1.h"
#import "WebViewController.h"

@interface ServicesMenuViewController ()

@end

@implementation ServicesMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [buttonWebsite setCenter:CGPointMake(160,140)];
        [buttonMyDetails setCenter:CGPointMake(160,310)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [buttonWebsite setCenter:CGPointMake(188,190)];
        [buttonMyDetails setCenter:CGPointMake(188,360)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [buttonWebsite setCenter:CGPointMake(207,220)];
        [buttonMyDetails setCenter:CGPointMake(207,390)];
    }
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [buttonWebsite setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonWebsite setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonWebsite layer] setCornerRadius:8.0f];
    [[buttonWebsite layer] setMasksToBounds:YES];
    buttonWebsite.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [buttonMyDetails setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonMyDetails setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonMyDetails layer] setCornerRadius:8.0f];
    [[buttonMyDetails layer] setMasksToBounds:YES];
    buttonMyDetails.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoWebsite {
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController"  bundle:nil url:@"https://www.northampton.gov.uk"  homePage:true addressSearch:false];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController  pushViewController:webViewController animated:YES];
    [webViewController release];
    
}

- (IBAction)gotoMyDetails {
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsViewController1 *vcDets = [[MyDetailsViewController1 alloc]initWithNibName:@"MyDetailsViewController1" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcDets animated:YES];
    [vcDets release];
}

@end

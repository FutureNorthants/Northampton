//
//  MyDetailsPhoneViewController.m
//  MyNBC
//
//  Created by Kevin White on 03/05/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "MyDetailsPhoneViewController.h"
#import "ServerResponseViewController.h"


@implementation MyDetailsPhoneViewController

@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    fromReport=false;
    fromContact=false;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact{
    fromReport=paramFromReport;
    fromContact=paramFromContact;
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
    self.navigationItem.title=@"My Phone Number";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [textView setCenter:CGPointMake(160,60)];
        [button setCenter:CGPointMake(160,145)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [textView setCenter:CGPointMake(160,95)];
        [button setCenter:CGPointMake(160,215)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [textView setCenter:CGPointMake(188,145)];
        [button setCenter:CGPointMake(188,265)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [textView setCenter:CGPointMake(207,175)];
        [button setCenter:CGPointMake(207,295)];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    button.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"PhoneNumber"]){
        textView.text=[defaults objectForKey:@"PhoneNumber"];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)flag {
    [super viewWillAppear:flag];
    [textView becomeFirstResponder];
}

- (IBAction)submitPhoneNumber:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textView.text forKey:@"PhoneNumber"];
    [defaults synchronize];
    if(fromReport||fromContact){
        ServerResponseViewController *vcServer = [[ServerResponseViewController alloc] initWithNibName:@"ServerResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        [self.navigationController pushViewController:vcServer animated:YES];
        [vcServer release];
    }else
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
    }
    
}

@end

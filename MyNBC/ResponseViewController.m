//
//  ResponseViewController.m
//  MyNBC
//
//  Created by Kevin White on 28/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ResponseViewController.h"
#import "MyDetailsEmailViewController.h"
#import "MyDetailsPhoneViewController.h"
#import "ServerResponseViewController.h"

@implementation ResponseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    fromReport=false;
    fromContact=false;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact
{
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
    
    if (fromContact){
        self.navigationItem.title=@"Preferred Contact?";
        [buttonResponseNo setHidden:TRUE];
    }else{
        self.navigationItem.title=@"Want updates?";
    }
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [buttonResponseEmail setCenter:CGPointMake(160,75)];
        [buttonResponsePhone setCenter:CGPointMake(160,175)];
        [buttonResponseNo setCenter:CGPointMake(160,275)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [buttonResponseEmail setCenter:CGPointMake(160,125)];
        [buttonResponsePhone setCenter:CGPointMake(160,225)];
        [buttonResponseNo setCenter:CGPointMake(160,325)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [buttonResponseEmail setCenter:CGPointMake(188,175)];
        [buttonResponsePhone setCenter:CGPointMake(188,275)];
        [buttonResponseNo setCenter:CGPointMake(188,375)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [buttonResponseEmail setCenter:CGPointMake(207,205)];
        [buttonResponsePhone setCenter:CGPointMake(207,305)];
        [buttonResponseNo setCenter:CGPointMake(207,405)];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [buttonResponseEmail setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonResponseEmail setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonResponseEmail layer] setCornerRadius:8.0f];
    [[buttonResponseEmail layer] setMasksToBounds:YES];
    buttonResponseEmail.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [buttonResponsePhone setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonResponsePhone setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonResponsePhone layer] setCornerRadius:8.0f];
    [[buttonResponsePhone layer] setMasksToBounds:YES];
    buttonResponsePhone.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [buttonResponseNo setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonResponseNo setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonResponseNo layer] setCornerRadius:8.0f];
    [[buttonResponseNo layer] setMasksToBounds:YES];
    buttonResponseNo.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)responseByEMail:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"email" forKey:@"ReplyBy"];
    [defaults synchronize];
    if([defaults objectForKey:@"EmailAddress"]&&![[defaults objectForKey:@"EmailAddress"]isEqualToString:@""]){
        ServerResponseViewController *vcServer = [[ServerResponseViewController alloc] initWithNibName:@"ServerResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        [self.navigationController pushViewController:vcServer animated:YES];
        [vcServer release];
    }else{
        MyDetailsEmailViewController *vcEmail = [[MyDetailsEmailViewController alloc] initWithNibName:@"MyDetailsEmailViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        [self.navigationController pushViewController:vcEmail animated:YES];
        [vcEmail release];
    }
}

- (IBAction)responseByPhone:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"phone" forKey:@"ReplyBy"];
    [defaults synchronize];
    if([defaults objectForKey:@"PhoneNumber"]&&![[defaults objectForKey:@"PhoneNumber"]isEqualToString:@""]){
        ServerResponseViewController *vcServer = [[ServerResponseViewController alloc] initWithNibName:@"ServerResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        [self.navigationController pushViewController:vcServer animated:YES];
        [vcServer release];
    }else{
        MyDetailsPhoneViewController *vcEmail = [[MyDetailsPhoneViewController alloc] initWithNibName:@"MyDetailsPhoneViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        [self.navigationController pushViewController:vcEmail animated:YES];
        [vcEmail release];
    }
    
}

- (IBAction)responseNotRequired:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"none" forKey:@"ReplyBy"];
    [defaults synchronize];
    ServerResponseViewController *vcServer = [[ServerResponseViewController alloc] initWithNibName:@"ServerResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
    [self.navigationController pushViewController:vcServer animated:YES];
    [vcServer release];
}

@end

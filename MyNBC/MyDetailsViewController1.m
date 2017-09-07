//
//  MyDetailsViewController1.m
//  MyNBC
//
//  Created by Kevin White on 20/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "MyDetailsViewController1.h"
#import "MyDetailsNameViewController.h"
#import "MyDetailsEmailViewController.h"
#import "MyDetailsPhoneViewController.h"
#import "MyDetailsPostcodeViewController.h"

@implementation MyDetailsViewController1

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
    self.navigationItem.title=@"My Details";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [changeName setCenter:CGPointMake(160,65)];
        [changePostcode setCenter:CGPointMake(160,145)];
        [changeEmail setCenter:CGPointMake(160,225)];
        [changePhoneNumber setCenter:CGPointMake(160,305)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [changeName setCenter:CGPointMake(160,75)];
        [changePostcode setCenter:CGPointMake(160,175)];
        [changeEmail setCenter:CGPointMake(160,275)];
        [changePhoneNumber setCenter:CGPointMake(160,375)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [changeName setCenter:CGPointMake(188,125)];
        [changePostcode setCenter:CGPointMake(188,225)];
        [changeEmail setCenter:CGPointMake(188,325)];
        [changePhoneNumber setCenter:CGPointMake(188,425)];
        
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [changeName setCenter:CGPointMake(207,155)];
        [changePostcode setCenter:CGPointMake(207,255)];
        [changeEmail setCenter:CGPointMake(207,355)];
        [changePhoneNumber setCenter:CGPointMake(207,455)];
        
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [changeName setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [changeName setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[changeName layer] setCornerRadius:8.0f];
    [[changeName layer] setMasksToBounds:YES];
    changeName.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [changePostcode setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [changePostcode setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[changePostcode layer] setCornerRadius:8.0f];
    [[changePostcode layer] setMasksToBounds:YES];
    changePostcode.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [changeEmail setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [changeEmail setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[changeEmail layer] setCornerRadius:8.0f];
    [[changeEmail layer] setMasksToBounds:YES];
    changeEmail.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    [changePhoneNumber setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [changePhoneNumber setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[changePhoneNumber layer] setCornerRadius:8.0f];
    [[changePhoneNumber layer] setMasksToBounds:YES];
    changePhoneNumber.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitSetName:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsNameViewController *vcName = [[MyDetailsNameViewController alloc] initWithNibName:@"MyDetailsNameViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcName animated:YES];
    [vcName release];
}

- (IBAction)submitSetPostcode:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsPostcodeViewController *vcPostcode = [[MyDetailsPostcodeViewController alloc] initWithNibName:@"MyDetailsPostcodeViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcPostcode animated:YES];
    [vcPostcode release];
}

- (IBAction)submitSetEmail:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsEmailViewController *vcEmail = [[MyDetailsEmailViewController alloc] initWithNibName:@"MyDetailsEmailViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcEmail animated:YES];
    [vcEmail release];
}

- (IBAction)submitSetPhoneNumber:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsPhoneViewController *vcPhone = [[MyDetailsPhoneViewController alloc] initWithNibName:@"MyDetailsPhoneViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcPhone animated:YES];
    [vcPhone release];
    
}

@end

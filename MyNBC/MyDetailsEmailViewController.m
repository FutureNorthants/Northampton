//
//  MyDetailsEmailViewController.m
//  MyNBC
//
//  Created by Kevin White on 23/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "MyDetailsEmailViewController.h"
#import "ServerResponseViewController.h"

@implementation MyDetailsEmailViewController

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
    self.navigationItem.title=@"My Email Address";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [textView setCenter:CGPointMake(160,75)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [textView setCenter:CGPointMake(160,125)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [textView setCenter:CGPointMake(188,175)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [textView setCenter:CGPointMake(207,205)];
    }
    
    textView.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"EmailAddress"]){
        textView.text=[defaults objectForKey:@"EmailAddress"];
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textField.text forKey:@"EmailAddress"];
    [defaults synchronize];
    if(fromReport||fromContact){
        ServerResponseViewController *vcServer = [[ServerResponseViewController alloc] initWithNibName:@"ServerResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        [self.navigationController pushViewController:vcServer animated:YES];
        [vcServer release];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
    }
    return YES;
}

@end

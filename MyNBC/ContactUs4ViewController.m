//
//  ContactUs4ViewController.m
//  MyNBC
//
//  Created by Kevin White on 09/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ContactUs4ViewController.h"
#import "MyDetailsNameViewController.h"
#import "MyDetailsPostcodeViewController.h"
#import "ResponseViewController.h"

@implementation ContactUs4ViewController

@synthesize textView;

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
    self.navigationItem.title=@"Your message";
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(setContactText:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [sendButton release];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [textView setCenter:CGPointMake(160,100)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        CGRect frameRect = textView.frame;
        frameRect.size.height = 360;
        textView.frame = frameRect;
        [textView setCenter:CGPointMake(160,175)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        CGRect frameRect = textView.frame;
        frameRect.size.height = 330;
        textView.frame = frameRect;
        [textView setCenter:CGPointMake(188,175)];        
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        CGRect frameRect = textView.frame;
        frameRect.size.height = 330;
        textView.frame = frameRect;
        [textView setCenter:CGPointMake(207,175)];
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

- (IBAction)setContactText:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textView.text forKey:@"ContactText"];
    [defaults synchronize];
    if(![defaults objectForKey:@"CustomerName"]&&![[defaults objectForKey:@"CustomerName"]isEqualToString:@""]){
        MyDetailsNameViewController *vcEmail = [[MyDetailsNameViewController alloc] initWithNibName:@"MyDetailsNameViewController" bundle:nil fromReport:false fromContact:true];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        [self.navigationController pushViewController:vcEmail animated:YES];
        [vcEmail release];
    }else{
        if(![defaults objectForKey:@"Postcode"]&&![[defaults objectForKey:@"Postcode"]isEqualToString:@""]){
            MyDetailsPostcodeViewController *vcPostcode = [[MyDetailsPostcodeViewController alloc] initWithNibName:@"MyDetailsPostcodeViewController" bundle:nil fromReport:false fromContact:true];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcPostcode animated:YES];
            [vcPostcode release];
        }else{
            ResponseViewController *vcResponse = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil fromReport: false fromContact:true];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcResponse animated:YES];
            [vcResponse release];
        }
    }
}

- (void)viewWillAppear:(BOOL)flag {
    [super viewWillAppear:flag];
    [textView becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [textView becomeFirstResponder];
}

@end

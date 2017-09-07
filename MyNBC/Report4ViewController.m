//
//  Report4ViewController.m
//  MyNBC
//
//  Created by Kevin White on 27/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report4ViewController.h"
#import "ResponseViewController.h"

@implementation Report4ViewController

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
    self.navigationItem.title=@"Any details?";
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Next"                                            
                                   style:UIBarButtonItemStylePlain
                                   target:self 
                                   action:@selector(setDetails:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [sendButton release];
    textView.returnKeyType = UIReturnKeyDone;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [textView setCenter:CGPointMake(160,100)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [textView setCenter:CGPointMake(160,135)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [textView setCenter:CGPointMake(187,135)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [textView setCenter:CGPointMake(207,135)];
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

- (void)viewWillAppear:(BOOL)flag {
    [super viewWillAppear:flag];
   [textView becomeFirstResponder];
}

- (IBAction)setDetails:(id)sender{
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    [self moveOnToNextScreen];
}

- (BOOL) textView:(UITextView *)paramTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [paramTextView resignFirstResponder];
        [self moveOnToNextScreen];
        return NO;
    }else{
        return YES;
    }
}

-(void)moveOnToNextScreen{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:textView.text forKey:@"ProblemDescription"];    
    [defaults synchronize]; 
    ResponseViewController *vcResponse = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil fromReport:true fromContact:false];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcResponse animated:YES];
    [vcResponse release];    
}


@end

//
//  BinFinder3ViewController.m
//  MyNBC
//
//  Created by Kevin White on 16/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder3ViewController.h"
#import "WebViewController.h"

@implementation BinFinder3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil postcodeParam:(NSString *)postcodeParam
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *part1 = [[postcodeParam substringWithRange:NSMakeRange(0, 3)] stringByAppendingString:@" "];
        postcode = [part1 stringByAppendingString:[postcodeParam substringWithRange:NSMakeRange(3, 3)]];
        [postcode retain];
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
    self.navigationItem.title=@"Sorry";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [label1 setCenter:CGPointMake(160,98)];
            [label1 setTextColor:[UIColor blackColor]];
            [lookupResponse setCenter:CGPointMake(160,151)];
            [lookupResponse setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [buttonCheck setCenter:CGPointMake(160,213)];
            [label2 setCenter:CGPointMake(160,353)];
            [label2 setTextColor:[UIColor blackColor]];
            [buttonCall setCenter:CGPointMake(160,418)];
        }else{
            [label1 setCenter:CGPointMake(160,108)];
            [lookupResponse setCenter:CGPointMake(160,163)];
            [buttonCheck setCenter:CGPointMake(160,223)];
            [label2 setCenter:CGPointMake(160,363)];
            [buttonCall setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [label1 setCenter:CGPointMake(160,60)];
            [label1 setTextColor:[UIColor blackColor]];
            [lookupResponse setCenter:CGPointMake(160,115)];
            [lookupResponse setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [buttonCheck setCenter:CGPointMake(160,175)];
            [label2 setCenter:CGPointMake(160,275)];
            [label2 setTextColor:[UIColor blackColor]];
            [buttonCall setCenter:CGPointMake(160,330)];
        }
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [buttonCheck setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonCheck setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonCheck layer] setCornerRadius:8.0f];
        [[buttonCheck layer] setMasksToBounds:YES];
        buttonCheck.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
        [buttonCall setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonCall setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonCall layer] setCornerRadius:8.0f];
        [[buttonCall layer] setMasksToBounds:YES];
        buttonCall.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    }else{
        [[buttonCheck layer] setCornerRadius:8.0f];
        [[buttonCheck layer] setMasksToBounds:YES];
        [[buttonCheck layer] setBorderWidth:1.0f];
        [[buttonCheck layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                 green:30/255.0
                                                                  blue:72/255.0
                                                                 alpha:1.0] CGColor]];
        
        
        [[buttonCall layer] setCornerRadius:8.0f];
        [[buttonCall layer] setMasksToBounds:YES];
        [[buttonCall layer] setBorderWidth:1.0f];
        [[buttonCall layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                green:30/255.0
                                                                 blue:72/255.0
                                                                alpha:1.0] CGColor]];
    }

    

    [lookupResponse setText:postcode];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitFindPostcode:(id)sender;{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController"  bundle:nil url:@"http://www.royalmail.com/postcode-finder-sme"  homePage:false addressSearch:true];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController  pushViewController:webViewController animated:YES];
    [webViewController release];
}

- (IBAction)submitCallUs:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    [[UIApplication sharedApplication] 
     openURL:[NSURL URLWithString:@"tel://03003307000"]];
}

@end

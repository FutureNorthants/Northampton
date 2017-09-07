//
//  WebViewController.m
//  MyNBC
//
//  Created by Kevin White on 24/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize website;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString *)paramURL homePage:(bool)paramHomePage addressSearch:(bool)paramAddressSearch
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        websiteUrl=paramURL;
        homePage=paramHomePage;
        addressSearch=paramAddressSearch;
    }
    return self;
}

- (void)dealloc
{
    [website setDelegate:nil];
    [website stopLoading];
    [website release];
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
    if(!homePage&&!addressSearch){
        UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Home"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(refresh:)];
        
        [button setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
        
        self.navigationItem.leftBarButtonItem = button;
        [button release];
    }
    website = [[UIWebView alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        if(homePage){
            website.frame = CGRectMake(0, 0, 320, 431);
        }else{
            website.frame = CGRectMake(0, 0, 320, 370);
        }
        if(!homePage&&!addressSearch){
            websiteUrl=@"social3-5";
        }
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        if(homePage){
            website.frame = CGRectMake(0, 0, 320, 519);
        }else{
            website.frame = CGRectMake(0, 0, 320, 458);
        }
        if(!homePage&&!addressSearch){
            websiteUrl=@"social4-0";
        }
    }
    
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        if(homePage){
            website.frame = CGRectMake(0, 0, 375, 618);
        }else{
            website.frame = CGRectMake(0, 0, 375, 557);
        }
        if(!homePage&&!addressSearch){
            websiteUrl=@"social4-0";
        }
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        if(homePage){
            website.frame = CGRectMake(0, 0, 414, 687);
        }else{
            website.frame = CGRectMake(0, 0, 414, 626);
        }
        if(!homePage&&!addressSearch){
            websiteUrl=@"social4-0";
        }
    }
    
    self.website.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [website setBackgroundColor:[UIColor colorWithRed:209/255.0
                                                green:211/255.0
                                                 blue:212/255.0
                                                alpha:1.0]];
    [website setOpaque:NO];
    [website setDelegate:self];
    [[self view] addSubview:[self website]];
    indicator = [self showActivityIndicatorOnView:self.parentViewController.view];
    if (!homePage&&!addressSearch) {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3", @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        [website loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:websiteUrl ofType:@"html"]isDirectory:NO]]];
        [dictionary release];
    }else{
        NSURL *url = [[NSURL alloc] initWithString:websiteUrl];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [website loadRequest:requestObj];
        [url release];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([error code] != -999) {
        [indicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Sorry, this page is currently unavailable"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)refresh:(id)sender {
    indicator = [self showActivityIndicatorOnView:self.parentViewController.view];
    [website loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:websiteUrl ofType:@"html"]isDirectory:NO]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIActivityIndicatorView *)showActivityIndicatorOnView:(UIView*)aView
{
    CGSize viewSize = aView.bounds.size;
    
    // create new dialog box view and components
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]
                                                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // other size? change it
    activityIndicatorView.bounds = CGRectMake(0, 0, 65, 65);
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.alpha = 0.7f;
    activityIndicatorView.backgroundColor = [UIColor blackColor];
    activityIndicatorView.layer.cornerRadius = 10.0f;
    
    // display it in the center of your view
    activityIndicatorView.center = CGPointMake(viewSize.width / 2.0, viewSize.height / 2.0);
    
    [aView addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    return [activityIndicatorView autorelease];
}


@end

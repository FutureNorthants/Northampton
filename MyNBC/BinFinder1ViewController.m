//
//  BinFinder1ViewController.m
//  MyNBC
//
//  Created by Kevin White on 07/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder1ViewController.h"
#import "BinFinder2ViewController.h"
#import "BinFinder3ViewController.h"
#import "BinFinder4ViewController.h"
#import "xmlBinParser.h"

@implementation BinFinder1ViewController

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
    
    awaitingResponse=false;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        [screenText setCenter:CGPointMake(180,50)];
        [postcodePicker setCenter:CGPointMake(160,220)];
        [button setCenter:CGPointMake(160,418)];
    }
    else // 3.5 inch
    {
        [button setCenter:CGPointMake(160,330)];
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [screenText setTextColor:[UIColor blackColor]];
        [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[button layer] setCornerRadius:8.0f];
        [[button layer] setMasksToBounds:YES];
        button.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    }else{
        [[button layer] setCornerRadius:8.0f];
        [[button layer] setMasksToBounds:YES];
        [[button layer] setBorderWidth:1.0f];
        [[button layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                            green:30/255.0
                                                             blue:72/255.0
                                                            alpha:1.0] CGColor]];
    }
    
    numbers = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil]; 
    alphabet = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil]; 
    self.navigationItem.title=@"Find Your Bin Collection Day";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"Postcode"]){
        [postcodePicker selectRow:[numbers indexOfObject:[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(2,1)]] inComponent:2 animated:YES];
        [postcodePicker selectRow:[numbers indexOfObject:[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(3,1)]] inComponent:3 animated:YES];
        [postcodePicker selectRow:[alphabet indexOfObject:[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(4,1)]] inComponent:4 animated:YES];
        [postcodePicker selectRow:[alphabet indexOfObject:[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(5,1)]] inComponent:5 animated:YES];
    }else{
        [postcodePicker selectRow:[numbers indexOfObject: @"1"] inComponent:2 animated:YES];
        [postcodePicker selectRow:[numbers indexOfObject: @"1"] inComponent:3 animated:YES];
        [postcodePicker selectRow:[alphabet indexOfObject: @"D"] inComponent:4 animated:YES];
        [postcodePicker selectRow:[alphabet indexOfObject: @"E"] inComponent:5 animated:YES];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 10;
            break;
        case 4:
            return 26;
            break;
        case 5:
            return 26;
            break;

        default:
            return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return @"N";
            break;
        case 1:
            return @"N";
            break;
        case 2:
            return [numbers objectAtIndex:row];
            break;
        case 3:
            return [numbers objectAtIndex:row];
            break;
        case 4:            
            return [alphabet objectAtIndex:row];
            break;
        case 5:
            return [alphabet objectAtIndex:row];
            break;
        default:
            return @"";
    }
}

-(IBAction)submitPostCode:(id)sender{
    if(!awaitingResponse){
        [postcodePicker setUserInteractionEnabled:NO];
        SystemSoundID klick;
        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
        AudioServicesPlaySystemSound(klick);
       indicator = [self showActivityIndicatorOnView:self.parentViewController.view];
       awaitingResponse=true;
        
       NSString *temp1 = @"NN";
       NSString *temp2 = [temp1 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:2]]];
       NSString *temp3 = [temp2 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:3]]];
       NSString *temp4 = [temp3 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:4]]];
       postCode = [temp4 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:5]]];
       NSString *preURL = @"https:selfserve.northampton.gov.uk/mycouncil/BinRoundFinder?postcode=";
       NSString *postURL = @"&mobileApp=true";
       NSString *url1 = [preURL stringByAppendingString:postCode];
       NSString *url2 = [url1 stringByAppendingString:postURL];
       NSURLRequest *binXML=[NSURLRequest requestWithURL:[NSURL URLWithString:url2]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:30.0];
       nbcBinConnection=[[NSURLConnection alloc] initWithRequest:binXML delegate:self];
       if (nbcBinConnection) {
           xmlData = [[NSMutableData data] retain];
       } else {
        [self requestFailed];
       }  
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [xmlData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [postcodePicker setUserInteractionEnabled:YES];
    awaitingResponse=false;
    [indicator stopAnimating];
    xmlBinParser *xmlParser = [[[xmlBinParser alloc]init]autorelease];
    [xmlParser parseThis:[[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding]autorelease]];
    [connection release];
    [xmlData release];
    
    NSString *temp1 = @"NN";
    NSString *temp2 = [temp1 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:2]]];
    NSString *temp3 = [temp2 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:3]]];
    NSString *temp4 = [temp3 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:4]]];
    NSString *postCode2 = [temp4 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:5]]];

    switch ([[xmlParser xmlBinEntries]count]) {
        case 0:
        {
            BinFinder3ViewController *vcBin3 = [[BinFinder3ViewController alloc] initWithNibName:@"BinFinder3ViewController" bundle:nil postcodeParam:postCode2];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin3 animated:YES];
            [vcBin3 release];
            break;
        }
        case 1:
        {
            BinFinder4ViewController *vcBin4 = [[BinFinder4ViewController alloc]initWithNibName:@"BinFinder4ViewController" bundle:nil data:[xmlParser xmlBinEntries] arrayEntry:0  postcodeParam:postCode2];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin4 animated:YES];
            [vcBin4 release];
            break;
        }
        default:
        {
            BinFinder2ViewController *vcBin2 = [[BinFinder2ViewController alloc] initWithNibName:@"BinFinder2ViewController" bundle:nil data:[xmlParser xmlBinEntries] postcodeParam:postCode2];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin2 animated:YES];
            [vcBin2 release];
            break;
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self requestFailed];
    [connection release];
}

- (void)requestFailed{
    awaitingResponse=false;
    [postcodePicker setUserInteractionEnabled:YES];
    [indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Sorry, this service is currently unavailable. Please try again later."
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];

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

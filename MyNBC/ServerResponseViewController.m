//
//  ServerResponseViewController.m
//  MyNBC
//
//  Created by Kevin White on 30/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ServerResponseViewController.h"


@implementation ServerResponseViewController

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
    [xmlParser release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [labelCallNumberText setCenter:CGPointMake(160,168)];
            [labelCallNumber setCenter:CGPointMake(160,243)];
            [labelSlaDateText setCenter:CGPointMake(160,291)];
            [labelSlaDate setCenter:CGPointMake(160,361)];
            [retryButton setCenter:CGPointMake(160,418)];
        }else{
            [labelCallNumberText setCenter:CGPointMake(160,168)];
            [labelCallNumber setCenter:CGPointMake(160,243)];
            [labelSlaDateText setCenter:CGPointMake(160,291)];
            [labelSlaDate setCenter:CGPointMake(160,361)];
            [retryButton setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [labelCallNumberText setCenter:CGPointMake(160,80)];
            [labelCallNumber setCenter:CGPointMake(160,155)];
            [labelSlaDateText setCenter:CGPointMake(160,203)];
            [labelSlaDate setCenter:CGPointMake(160,273)];
            [retryButton setCenter:CGPointMake(160,330)];
        }
    }

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [labelCallNumberText setTextColor:[UIColor blackColor]];
        [labelCallNumber setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
        [labelSlaDateText setTextColor:[UIColor blackColor]];
        [labelSlaDate setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
        [retryButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [retryButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[retryButton layer] setCornerRadius:8.0f];
        [[retryButton layer] setMasksToBounds:YES];
        retryButton.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    }else{
        [[retryButton layer] setCornerRadius:8.0f];
        [[retryButton layer] setMasksToBounds:YES];
        [[retryButton layer] setBorderWidth:1.0f];
        [[retryButton layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                 green:30/255.0
                                                                  blue:72/255.0
                                                                 alpha:1.0] CGColor]];
    }

    self.navigationItem.hidesBackButton = YES;
    [self submit];
}

-(void)submit{
    [retryButton setHidden:TRUE];
    self.navigationItem.title=@"Please Wait";
    indicator = [self showActivityIndicatorOnView:self.parentViewController.view];
    if(fromContact){
        [self submitContact];   
    }else{
        [self submitReport];
    }
   
}

-(void)submitReport{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    problemLocation.latitude=[defaults doubleForKey:@"ProblemLatitude"];
    problemLocation.longitude=[defaults doubleForKey:@"ProblemLongitude"];    
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init]autorelease];    
    [geoCoder reverseGeocodeLocation:[[[CLLocation alloc] initWithLatitude:problemLocation.latitude longitude:problemLocation.longitude]autorelease] completionHandler:
     ^(NSArray* placemarks, NSError* error){
         if ([placemarks count] > 0)
         {
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:[[placemarks objectAtIndex:0]thoroughfare] forKey:@"ProblemLocation"];    
             [defaults synchronize];
             [self submitReport2];
          }
     }];
}

-(void)submitReport2{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *url = @"http:localhost:8080/mycouncildev/CreateCall";
    NSString *url = @"https:selfserve.northampton.gov.uk/mycouncil-test/CreateCall";
    //NSString *url = @"https:selfserve.northampton.gov.uk/mycouncil/CreateCall";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]; 
    [request setHTTPMethod:@"POST"]; 
    [request setTimeoutInterval:240];
    [request addValue:@"image/png" forHTTPHeaderField: @"Content-Type"]; 
    [request addValue:@"myNBC" forHTTPHeaderField: @"dataSource"];
    [request addValue:[defaults objectForKey:@"DeviceID"] forHTTPHeaderField: @"DeviceID"];
    [request addValue:[defaults objectForKey:@"ProblemNumber"] forHTTPHeaderField: @"ProblemNumber"];
    [request addValue:[defaults objectForKey:@"ProblemLatitude"] forHTTPHeaderField: @"ProblemLatitude"];
    [request addValue:[defaults objectForKey:@"ProblemLongitude"] forHTTPHeaderField: @"ProblemLongitude"];
    [request addValue:[[defaults objectForKey:@"ProblemDescription"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField: @"ProblemDescription"];
    [request addValue:[defaults objectForKey:@"ProblemLocation"] forHTTPHeaderField: @"ProblemLocation"];
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"none"]){
      [request addValue:@"" forHTTPHeaderField: @"ProblemEmail"]; 
      [request addValue:@"" forHTTPHeaderField: @"ProblemPhone"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"email"]){
        [request addValue:[defaults objectForKey:@"EmailAddress"] forHTTPHeaderField: @"ProblemEmail"]; 
        [request addValue:@"" forHTTPHeaderField: @"ProblemPhone"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"phone"]){
        [request addValue:@"" forHTTPHeaderField: @"ProblemEmail"]; 
        [request addValue:[defaults objectForKey:@"PhoneNumber"] forHTTPHeaderField: @"ProblemPhone"];
    }
    if([defaults boolForKey:@"UseImage"]){
        [request addValue:@"true" forHTTPHeaderField: @"includesImage"];
        NSData *imageData = [defaults objectForKey:@"ImageData"];
        NSMutableData *body = [NSMutableData data];       
        [body appendData:[NSData dataWithData:imageData]]; 
        [request setHTTPBody:body]; 
    }else{
        [request addValue:@"false" forHTTPHeaderField: @"includesImage"];
    }
    serverConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (serverConnection) {
        serverResponse = [[NSMutableData data] retain];
    } else {
        [self submitFailed];
    }        
}

-(void)submitContact{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    //NSString *url = @"http:localhost:8080/mycouncil/CreateContact";
    //NSString *url = @"http:selfserve.northampton.gov.uk/mycouncil-test/CreateContact";
    NSString *url = @"https:selfserve.northampton.gov.uk/mycouncil/CreateContact";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]; 
    [request setHTTPMethod:@"POST"]; 
    [request setTimeoutInterval:240];
    [request addValue:@"myNBC" forHTTPHeaderField: @"dataSource"];
    [request addValue:[defaults objectForKey:@"DeviceID"] forHTTPHeaderField: @"DeviceID"];
    [request addValue:[defaults objectForKey:@"ContactServiceArea"] forHTTPHeaderField: @"service"];
    [request addValue:[defaults objectForKey:@"ContactSection"] forHTTPHeaderField: @"team"];
    [request addValue:[defaults objectForKey:@"ContactReason"] forHTTPHeaderField: @"reason"];
    [request addValue:[defaults objectForKey:@"CustomerName"] forHTTPHeaderField: @"name"];
    [request addValue:[defaults objectForKey:@"Postcode"] forHTTPHeaderField: @"Postcode"];
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"email"]){
        [request addValue:[defaults objectForKey:@"EmailAddress"] forHTTPHeaderField: @"emailAddress"]; 
        [request addValue:@"" forHTTPHeaderField: @"PhoneNumber"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"phone"]){
        [request addValue:@"" forHTTPHeaderField: @"EmailAddress"]; 
        [request addValue:[defaults objectForKey:@"PhoneNumber"] forHTTPHeaderField: @"phoneNumber"];
    }
    [request addValue:[[defaults objectForKey:@"ContactText"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField: @"details"];
    serverConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (serverConnection) {
        serverResponse = [[NSMutableData data] retain];
    } else {
        [self submitFailed];
    }        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self submitFailed];
    [connection release];

}

- (void)submitFailed{
    [indicator stopAnimating];
    self.navigationItem.title=@"Sorry";
    if(fromContact){
       labelCallNumberText.text=@"Your contact could not be sent"; 
    }else{
       labelCallNumberText.text=@"The problem could not be reported";
    }
    labelSlaDateText.text=@"Please try again";
    [retryButton setHidden:FALSE]; 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [serverResponse setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [serverResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseThis:[[[NSString alloc] initWithData:serverResponse encoding:NSUTF8StringEncoding]autorelease]];
    [indicator stopAnimating];
    [connection release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)parseThis:(NSString *)xml 
{
    NSLog(@"xml=%@",xml	);
    xmlParser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
    
}

#pragma mark NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser 
{
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError 
{
    [self submitFailed];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
    [currentElement release];
    currentElement = [elementName copy];
    
    if ([currentElement isEqualToString:@"result"])
    {
        [result release];
        result = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"callNumber"])
    {
        [callNumber release];
        callNumber = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"slaDate"])
    {
        [slaDate release];
        slaDate = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"result"]) 
    {
        [result appendString:string];
    } 
    else if ([currentElement isEqualToString:@"callNumber"]) 
    {
        [callNumber appendString:string];
    } 
    else if ([currentElement isEqualToString:@"slaDate"]) 
    {
        [slaDate appendString:string];
        NSLog(@"parse=%@",slaDate);
    } 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"slaDate"]) 
    {
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568) // 4 inch
        {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                [labelCallNumberText setCenter:CGPointMake(160,128)];
                [labelCallNumber setCenter:CGPointMake(160,183)];
                [labelSlaDateText setCenter:CGPointMake(160,251)];
                [labelSlaDate setCenter:CGPointMake(160,301)];
            }else{
                [labelCallNumberText setCenter:CGPointMake(160,108)];
                [labelCallNumber setCenter:CGPointMake(160,163)];
                [labelSlaDateText setCenter:CGPointMake(160,231)];
                [labelSlaDate setCenter:CGPointMake(160,284)];
            }
        }
        
        self.navigationItem.title=@"Thank You";
        labelCallNumberText.text=@"Your call number is";
        labelCallNumber.text=callNumber;
        if(fromContact){
            if([slaDate isEqualToString:@"asap"]){
                labelSlaDateText.text=@"And will be responded to";
            }else{
                labelSlaDateText.text=@"And will be responded to by";
            }
        }else{
            if([slaDate isEqualToString:@"asap"]){
                labelSlaDateText.text=@"And will be resolved";
            }else{
                labelSlaDateText.text=@"And will be resolved by";
            }
        }
        NSLog(@"date=%@",slaDate);
        labelSlaDate.text=slaDate;
    }    
} 

- (NSString *)cleanseString:(NSMutableString *)inputString{
    NSString *cleansedString = [inputString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cleansedString = [cleansedString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    return cleansedString; 
}

- (IBAction)retrySubmit{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    labelSlaDateText.text=@"";
    labelCallNumberText.text=@"";
    [self submit];
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

//
//  Report5ViewController.m
//  MyNBC
//
//  Created by Kevin White on 04/05/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report5ViewController.h"
#import "Report2ViewController.h"

@implementation Report5ViewController
@synthesize mapView;
@synthesize mapSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationSet=false;
    }
    return self;
}

- (void)dealloc
{
    [locationManager stopUpdatingLocation];
    [locationManager setDelegate:nil];
    [locationManager release];
    [mapView setDelegate:nil];
    [mapView release];
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
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
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
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [mapSwitch setCenter:CGPointMake(160,17)];
            mapView.frame = CGRectMake(0, 35, 320, 370);
            [button setCenter:CGPointMake(160,418)];
        }else{
            mapView.frame = CGRectMake(0, 30, 320, 355);
            [button setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
          [mapSwitch setCenter:CGPointMake(160,17)];
           mapView.frame = CGRectMake(0, 35, 320, 375);
            [button setCenter:CGPointMake(160,330)];
        }else{
           mapView.frame = CGRectMake(0, 32, 320, 360);
          [button setCenter:CGPointMake(160,330)];
        }
    }
    
    showNormalMap=true;
    
    self.navigationItem.title=@"Pin the problem";
    problemLocation.latitude=52.23717;
    problemLocation.longitude=-0.894828;
    
    span.latitudeDelta=0.05;  
    span.longitudeDelta=0.05;
    
    region.span=span;
    region.center=problemLocation;
    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
     
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)setLocation {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *latitude = [[[NSString alloc] initWithFormat:@"%g", problemLocation.latitude]autorelease];
    NSString *longitude = [[[NSString alloc] initWithFormat:@"%g", problemLocation.longitude]autorelease];
    [defaults setObject:latitude forKey:@"ProblemLatitude"];
    [defaults setObject:longitude forKey:@"ProblemLongitude"];
    [defaults synchronize]; 
    Report2ViewController *vcReport2 = [[Report2ViewController alloc] initWithNibName:@"Report2ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport2 animated:YES];
    [vcReport2 release];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]autorelease];
    pin.animatesDrop = YES;
    pin.draggable = YES;
    [pin setSelected:YES];
    return pin;
}

- (void)mapView:(MKMapView *)mapViewParam annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    if (oldState == MKAnnotationViewDragStateNone && newState == MKAnnotationViewDragStateStarting) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if (newState == MKAnnotationViewDragStateNone && oldState == MKAnnotationViewDragStateEnding) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        problemLocation.latitude=annotationView.annotation.coordinate.latitude;
        problemLocation.longitude=annotationView.annotation.coordinate.longitude;
        region.center=problemLocation;
        [mapView setRegion:region animated:TRUE];
        [mapView regionThatFits:region];

    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(!locationSet){
        locationSet=true;
        problemLocation=newLocation.coordinate;
        region.span.latitudeDelta=0.005;
        region.span.longitudeDelta=0.005;
        region.center=problemLocation;
        [mapView setRegion:region animated:TRUE];
        [mapView regionThatFits:region];
        MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init]autorelease];
        [annotation setCoordinate:problemLocation];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    problemLocation.latitude=52.23717;
    problemLocation.longitude=-0.894828;
    region.span.latitudeDelta=0.005;
    region.span.longitudeDelta=0.005;
    region.center=problemLocation;
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init]autorelease];
    [annotation setCoordinate:problemLocation];
    [self.mapView addAnnotation:annotation];
}

-(IBAction) segmentedControlIndexChanged{
    if(showNormalMap){
        [mapView setMapType:MKMapTypeSatellite];
        showNormalMap=false;
    }else{
        [mapView setMapType:MKMapTypeStandard];
        showNormalMap=true;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end

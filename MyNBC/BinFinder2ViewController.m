//
//  BinFinder2ViewController.m
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder2ViewController.h"
#import "BinFinder4ViewController.h"
#import "BinEntry.h"

@implementation BinFinder2ViewController

@synthesize addresses;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)addressArray postcodeParam:postCode;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        addresses = addressArray;
        strPostcode = postCode;
        [postCode retain];
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
    self.navigationItem.title=@"Select Your Address";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [button setCenter:CGPointMake(160,330)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [addressPicker setCenter:CGPointMake(160,220)];
        [button setCenter:CGPointMake(160,418)];
    }
        
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [addressPicker setCenter:CGPointMake(188,290)];
        [button setCenter:CGPointMake(188,517)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [addressPicker setCenter:CGPointMake(207,320)];
        [button setCenter:CGPointMake(207,586)];
    }
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    button.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [addresses count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    BinEntry *currentAddress = [addresses objectAtIndex:row];
    return [currentAddress entryAddress];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    currentAddressArrayEntry = row;
}

- (IBAction)submitAddress:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    BinFinder4ViewController *vcBin4 = [[BinFinder4ViewController alloc]initWithNibName:@"BinFinder4ViewController" bundle:nil data:addresses arrayEntry:currentAddressArrayEntry  postcodeParam:strPostcode];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcBin4 animated:YES];
    [vcBin4 release];
}

@end

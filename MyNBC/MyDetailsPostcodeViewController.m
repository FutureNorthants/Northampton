//
//  MyDetailsPostcodeViewController.m
//  MyNBC
//
//  Created by Kevin White on 24/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "MyDetailsPostcodeViewController.h"
#import "ResponseViewController.h"

@implementation MyDetailsPostcodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fromReport=false;
        fromContact=false;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fromReport=paramFromReport;
        fromContact=paramFromContact;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [postcodePicker setCenter:CGPointMake(160,220)];
            [button setCenter:CGPointMake(160,418)];
        }else{
            [postcodePicker setCenter:CGPointMake(160,220)];
            [button setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [postcodePicker setCenter:CGPointMake(160,148)];
            [button setCenter:CGPointMake(160,330)];
        }
    }

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
    
    numbers = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
    alphabet = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil]; 

    self.navigationItem.title=@"My Postcode";
    
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
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSString *temp1 = @"NN";
    NSString *temp2 = [temp1 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:2]]];
    NSString *temp3 = [temp2 stringByAppendingString:[numbers objectAtIndex:[postcodePicker selectedRowInComponent:3]]];
    NSString *temp4 = [temp3 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:4]]];
    postCode = [temp4 stringByAppendingString:[alphabet objectAtIndex:[postcodePicker selectedRowInComponent:5]]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:postCode forKey:@"Postcode"];    
    [defaults synchronize]; 
    
    if(fromReport||fromContact){
        ResponseViewController *vcResponse = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil fromReport:fromReport fromContact:fromContact];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        [self.navigationController pushViewController:vcResponse animated:YES];
        [vcResponse release];    
    }else {
       [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
    }
}

@end

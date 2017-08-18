//
//  BinFinder5ViewController.m
//  MyNBC
//
//  Created by Kevin White on 17/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder5ViewController.h"


@implementation BinFinder5ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil date:(NSString *)date  day:(NSString *)day
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
        fireDate = [dateFormatter dateFromString:date];
        [fireDate retain];
        [dateFormatter release];
        
        strDay = [@" AM " stringByAppendingString:day];
        if([strDay isEqualToString:@" AM Monday"]){
            strPreviousDay=@" PM Sunday";
        }
        if([strDay isEqualToString:@" AM Tuesday"]){
            strPreviousDay=@" PM  Monday";
        }
        if([strDay isEqualToString:@" AM Wednesday"]){
            strPreviousDay=@" PM  Tuesday";
        }
        if([strDay isEqualToString:@" AM Thursday"]){
            strPreviousDay=@" PM  Wednesday";
        }
        if([strDay isEqualToString:@" AM Friday"]){
            strPreviousDay=@" PM  Thursday";
        }
        if([strDay isEqualToString:@" AM Saturday"]){
            strPreviousDay=@" PM  Friday";
        }
        if([strDay isEqualToString:@" AM Sunday"]){
            strPreviousDay=@" PM  Saturday";
        }
        intTime = [[date substringWithRange:NSMakeRange(8, 4)]intValue] + 1200;
        [strDay retain];
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
    self.navigationItem.title=@"Select a Reminder";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [reminderPicker setCenter:CGPointMake(160,220)];
            [buttonReminder setCenter:CGPointMake(160,418)];
        }else{
            [reminderPicker setCenter:CGPointMake(160,220)];
            [buttonReminder setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [reminderPicker setCenter:CGPointMake(160,147)];
            [buttonReminder setCenter:CGPointMake(160,335)];
        }
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [buttonReminder setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonReminder setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
        [[buttonReminder layer] setCornerRadius:8.0f];
        [[buttonReminder layer] setMasksToBounds:YES];
        buttonReminder.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    }else{
        [[buttonReminder layer] setCornerRadius:8.0f];
        [[buttonReminder layer] setMasksToBounds:YES];
        [[buttonReminder layer] setBorderWidth:1.0f];
        [[buttonReminder layer] setBackgroundColor:[[UIColor colorWithRed:170/255.0
                                                                    green:30/255.0
                                                                     blue:72/255.0
                                                                    alpha:1.0] CGColor]];
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 12;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger tempTime = intTime - (row * 100);
    NSString *tempDay=@"";
    NSString *strTempTime=@"";

    if(tempTime>1200){
        if(tempTime-1200<100){
            strTempTime=@"00"; 
        }else if(tempTime-1200<1000){
            strTempTime=@"0"; 
        }
        NSString *strTempTime2 = [strTempTime stringByAppendingString:[NSString stringWithFormat:@"%ld", (tempTime-1200)]];
        NSString *strTempTime3 = [[strTempTime2 substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@":"];
        NSString *strTempTime4 = [strTempTime3 stringByAppendingString:[strTempTime2 substringWithRange:NSMakeRange(2, 2)]];
        tempDay=[strTempTime4 stringByAppendingString:strDay];
    }else{
        if(tempTime<100){
            strTempTime=@"00"; 
        }else if(tempTime<1000){
            strTempTime=@"0"; 
        }
        NSString *strTempTime2 = [strTempTime stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)tempTime]];
        NSString *strTempTime3 = [[strTempTime2 substringWithRange:NSMakeRange(0, 2)] stringByAppendingString:@":"];
        NSString *strTempTime4 = [strTempTime3 stringByAppendingString:[strTempTime2 substringWithRange:NSMakeRange(2, 2)]];
        tempDay=[strTempTime4 stringByAppendingString:strPreviousDay];
        }
    return tempDay;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    fireDateModifier = row;
}

- (IBAction)submitSetReminder:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSDate *modifiedFireDate = [fireDate dateByAddingTimeInterval:60*60*fireDateModifier*-1];    
    UILocalNotification *localNotification = [[[UILocalNotification alloc] init]autorelease];
    localNotification.fireDate = modifiedFireDate;
    localNotification.alertBody = [NSString stringWithFormat:
                                   @"Put out bins"];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = -1;
    localNotification.repeatInterval = NSCalendarUnitWeekOfYear;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
                          message:@"Your reminder has  been set"
                          delegate:self cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}


@end

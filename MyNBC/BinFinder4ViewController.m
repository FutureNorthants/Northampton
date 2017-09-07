//
//  BinFinder4ViewController.m
//  MyNBC
//
//  Created by Kevin White on 16/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder4ViewController.h"
#import "BinFinder5ViewController.h"
#import "BinEntry.h"

@implementation BinFinder4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)addresses arrayEntry:(NSInteger) arrayEntry postcodeParam:(NSString *)postcodeParam
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *part1 = [[postcodeParam substringWithRange:NSMakeRange(0, 3)] stringByAppendingString:@" "];
        strPostcode = [part1 stringByAppendingString:[postcodeParam substringWithRange:NSMakeRange(3, 3)]];
        strCollectionDate =[[addresses objectAtIndex:arrayEntry] entryDate];
        strCollectionDay =[[addresses objectAtIndex:arrayEntry] entryDay];
        strCollectionText = [[addresses objectAtIndex:arrayEntry] entryType];
        NSString *strAMPM = @"";
        if([[[[addresses objectAtIndex:arrayEntry] entryDate ]substringWithRange:NSMakeRange(8, 2)] intValue] < 12){
            strAMPM = @" AM";
        }else{
            strAMPM = @" PM";
        }
        NSString *tempTime1 = [[[[addresses objectAtIndex:arrayEntry] entryDate ]substringWithRange:NSMakeRange(8, 2)] stringByAppendingString:@":"];
        NSString *tempTime2 = [tempTime1 stringByAppendingString:[[[addresses objectAtIndex:arrayEntry] entryDate ]substringWithRange:NSMakeRange(10, 2)]];
        strCollectionTime = [tempTime2 stringByAppendingString:strAMPM];
        [strPostcode retain];
        [strCollectionDate retain];
        [strCollectionDay retain];
        [strCollectionTime retain];
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
    [label1 setTextColor:[UIColor blackColor]];
    [collectionDay setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
    [label2 setTextColor:[UIColor blackColor]];
    [collectionText setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
    [label3 setTextColor:[UIColor blackColor]];
    [collectionTime setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
    [collectionDescription setTextColor:[UIColor blackColor]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [label1 setCenter:CGPointMake(160,25)];
        [collectionDay setCenter:CGPointMake(160,55)];
        [label2 setCenter:CGPointMake(160,85)];
        [collectionText setCenter:CGPointMake(160,115)];
        [label3 setCenter:CGPointMake(160,145)];
        [collectionTime setCenter:CGPointMake(160,175)];
        [collectionDescription setCenter:CGPointMake(160,235)];
        [buttonReminder setCenter:CGPointMake(160,330)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [label1 setCenter:CGPointMake(160,40)];
        [collectionDay setCenter:CGPointMake(160,80)];
        [label2 setCenter:CGPointMake(160,120)];
        [collectionText setCenter:CGPointMake(160,160)];
        [label3 setCenter:CGPointMake(160,200)];
        [collectionTime setCenter:CGPointMake(160,240)];
        [collectionDescription setCenter:CGPointMake(160,310)];
        [buttonReminder setCenter:CGPointMake(160,418)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [label1 setCenter:CGPointMake(188,90)];
        [collectionDay setCenter:CGPointMake(188,130)];
        [label2 setCenter:CGPointMake(188,170)];
        [collectionText setCenter:CGPointMake(188,210)];
        [label3 setCenter:CGPointMake(188,250)];
        [collectionTime setCenter:CGPointMake(188,290)];
        [collectionDescription setCenter:CGPointMake(188,360)];
        [buttonReminder setCenter:CGPointMake(188,468)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [label1 setCenter:CGPointMake(207,120)];
        [collectionDay setCenter:CGPointMake(207,160)];
        [label2 setCenter:CGPointMake(207,200)];
        [collectionText setCenter:CGPointMake(207,240)];
        [label3 setCenter:CGPointMake(207,280)];
        [collectionTime setCenter:CGPointMake(207,320)];
        [collectionDescription setCenter:CGPointMake(207,390)];
        [buttonReminder setCenter:CGPointMake(207,498)];
    }
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [buttonReminder setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonReminder setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[buttonReminder layer] setCornerRadius:8.0f];
    [[buttonReminder layer] setMasksToBounds:YES];
    buttonReminder.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    
    
    self.navigationItem.title=strPostcode;
    [collectionDay setText:strCollectionDay];
    if([strCollectionText isEqualToString:@"black"]){
        [collectionText setText:@"Black Wheelie Bin"];
        [collectionDescription setText:@"Your collections alternate between Black and Brown Wheelie Bins. We will collect all of your recycling every week."];
    }else if ([strCollectionText isEqualToString:@"brown"]){
        [collectionText setText:@"Brown Wheelie Bin"];
        [collectionDescription setText:@"Your collections alternate between Black and Brown Wheelie Bins. We will collect all of your recycling every week."];
    }
    else{
        [collectionText setText:@"Green Bags"];
        [collectionDescription setText:@"We will collect your Green Bags and all of your recycling every week."];
    }
    [collectionTime setText:strCollectionTime];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitSetReminder:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    BinFinder5ViewController *vcBin5 = [[BinFinder5ViewController alloc] initWithNibName:@"BinFinder5ViewController" bundle:nil date:strCollectionDate day:strCollectionDay];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    [self.navigationController pushViewController:vcBin5 animated:YES];
    [vcBin5 release];
}

@end

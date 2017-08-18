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
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) // 4 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [label1 setCenter:CGPointMake(160,40)];
            [label1 setTextColor:[UIColor blackColor]];
            [collectionDay setCenter:CGPointMake(160,80)];
            [collectionDay setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [label2 setCenter:CGPointMake(160,120)];
            [label2 setTextColor:[UIColor blackColor]];
            [collectionText setCenter:CGPointMake(160,160)];
            [collectionText setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [label3 setCenter:CGPointMake(160,200)];
            [label3 setTextColor:[UIColor blackColor]];
            [collectionTime setCenter:CGPointMake(160,240)];
            [collectionTime setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [collectionDescription setCenter:CGPointMake(160,310)];
            [collectionDescription setTextColor:[UIColor blackColor]];
            [buttonReminder setCenter:CGPointMake(160,418)];
        }else{
            [label1 setCenter:CGPointMake(160,40)];
            [collectionDay setCenter:CGPointMake(160,80)];
            [label2 setCenter:CGPointMake(160,120)];
            [collectionText setCenter:CGPointMake(160,160)];
            [label3 setCenter:CGPointMake(160,200)];
            [collectionTime setCenter:CGPointMake(160,240)];
            [collectionDescription setCenter:CGPointMake(160,310)];
            [buttonReminder setCenter:CGPointMake(160,418)];
        }
    }
    else // 3.5 inch
    {
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [label1 setCenter:CGPointMake(160,25)];
            [label1 setTextColor:[UIColor blackColor]];
            [collectionDay setCenter:CGPointMake(160,55)];
            [collectionDay setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [label2 setCenter:CGPointMake(160,85)];
            [label2 setTextColor:[UIColor blackColor]];
            [collectionText setCenter:CGPointMake(160,115)];
            [collectionText setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [label3 setCenter:CGPointMake(160,145)];
            [label3 setTextColor:[UIColor blackColor]];
            [collectionTime setCenter:CGPointMake(160,175)];
            [collectionTime setTextColor:[UIColor colorWithRed:0.0 green:153.0/255.0 blue:0.0 alpha:1.0]];
            [collectionDescription setCenter:CGPointMake(160,235)];
            [collectionDescription setTextColor:[UIColor blackColor]];
            [buttonReminder setCenter:CGPointMake(160,330)];
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
                                                                     blue:72/255.0                                                                    alpha:1.0] CGColor]];
    }

    
    
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

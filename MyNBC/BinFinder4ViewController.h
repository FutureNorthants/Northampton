//
//  BinFinder4ViewController.h
//  MyNBC
//
//  Created by Kevin White on 16/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BinFinder4ViewController : UIViewController {
    
    IBOutlet UILabel *collectionDay;
    IBOutlet UILabel *collectionText;
    IBOutlet UILabel *collectionDescription;
    IBOutlet UILabel *collectionTime;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    NSString *strPostcode;
    NSString *strCollectionDate;
    NSString *strCollectionDay;
    NSString *strCollectionText;
    NSString *strCollectionTime;
    IBOutlet UIButton *buttonReminder;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)addresses arrayEntry:(NSInteger) arrayEntry postcodeParam:(NSString *)postcodeParam;

- (IBAction)submitSetReminder:(id)sender;

@end

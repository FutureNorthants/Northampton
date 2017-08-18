//
//  MyDetailsPostcodeViewController.h
//  MyNBC
//
//  Created by Kevin White on 24/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MyDetailsPostcodeViewController : UIViewController<UIPickerViewDelegate> {
    NSArray *numbers;
    NSArray *alphabet;  
    NSString *postCode;
    IBOutlet UIButton *button;
    IBOutlet UIPickerView *postcodePicker;
    bool fromReport;
    bool fromContact;
}

- (IBAction)submitPostCode:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;

@end

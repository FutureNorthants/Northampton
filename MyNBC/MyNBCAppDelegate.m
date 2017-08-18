//
//  MyNBCAppDelegate.m
//  MyNBC
//
//  Created by Kevin White on 21/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "MyNBCAppDelegate.h"
#import "xmlContactsParser.h"
#import "xmlProblemsParser.h"

@implementation MyNBCAppDelegate

@synthesize window=_window;
@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.tabBarController;
    self.tabBarController.delegate = self;
    [self.window makeKeyAndVisible];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        navigation1Controller.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        navigation2Controller.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        navigation3Controller.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        navigation4Controller.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        navigation5Controller.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        
        navigation1Controller.navigationBar.barTintColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
        navigation2Controller.navigationBar.barTintColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
        navigation3Controller.navigationBar.barTintColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
        navigation4Controller.navigationBar.barTintColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
        navigation5Controller.navigationBar.barTintColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
        
        [navigation1Controller.navigationBar setTranslucent:NO];
        [navigation2Controller.navigationBar setTranslucent:NO];
        [navigation3Controller.navigationBar setTranslucent:NO];
        [navigation4Controller.navigationBar setTranslucent:NO];
        [navigation5Controller.navigationBar setTranslucent:NO];
        
        self.tabBarController.tabBar.tintColor = [[[UIColor alloc] initWithRed:0.00
                                                                        green:122.0/255.0
                                                                         blue:1.0
                                                                        alpha:1.0]autorelease];

        [self.tabBarController.tabBar setTranslucent:NO];
        

    }else{
        navigation1Controller.navigationBar.tintColor = [UIColor colorWithRed:170/255.0
                                                                        green:30/255.0
                                                                         blue:72/255.0
                                                                        alpha:1.0];
        navigation2Controller.navigationBar.tintColor = [UIColor colorWithRed:170/255.0
                                                                        green:30/255.0
                                                                         blue:72/255.0
                                                                        alpha:1.0];
        navigation3Controller.navigationBar.tintColor = [UIColor colorWithRed:170/255.0
                                                                        green:30/255.0
                                                                         blue:72/255.0
                                                                        alpha:1.0];
        navigation4Controller.navigationBar.tintColor = [UIColor colorWithRed:170/255.0
                                                                        green:30/255.0
                                                                         blue:72/255.0
                                                                        alpha:1.0];
        navigation5Controller.navigationBar.tintColor = [UIColor colorWithRed:170/255.0
                                                                        green:30/255.0
                                                                         blue:72/255.0
                                                                        alpha:1.0];
      }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    if(![defaults objectForKey:@"DeviceID"]){
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"-yyyy-MM-dd-HH-mm-ss"];
        NSDate *todaysDate = [NSDate date ];
        NSString *formattedDate = [formatter stringFromDate:todaysDate];
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        NSString *deviceID = [[(NSString *)CFUUIDCreateString(NULL, uuidRef) autorelease] stringByAppendingString:formattedDate];
        CFRelease(uuidRef);
        [defaults setObject:deviceID forKey:@"DeviceID"];  
        [defaults setObject:@"0" forKey:@"ContactOptionsVersion"];
        [defaults setObject:@"0" forKey:@"ProblemsVersion"];
        [defaults synchronize];
    }

    NSString* ContactsContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"contacts" 
                                                                                               ofType:@"xml"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    xmlContactsParser *contactParser = [[xmlContactsParser alloc]init];
    [contactParser parseThis:ContactsContent ContactOptionsVersion:[defaults objectForKey:@"ContactOptionsVersion"]];
    [contactParser release];

    NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"problems" 
                                                                                               ofType:@"xml"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    xmlProblemsParser *problemsParser = [[xmlProblemsParser alloc]init];
    [problemsParser parseThis:content ProblemsVersion:[defaults objectForKey:@"ProblemsVersion"]];
    [problemsParser release];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSLog(@"deviceToken: %@", deviceToken);
    //NSString *deviceId = [[NSString alloc] initWithData:deviceToken encoding:NSASCIIStringEncoding];
    
    //NSString *deviceId = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    //deviceId = [deviceId stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"deviceID: %@", [deviceToken description]);
    [defaults setObject:[deviceToken description] forKey:@"DeviceID"];
    [defaults synchronize];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"Failed to register with error : %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    application.applicationIconBadgeNumber++;
    NSString *msg = [NSString stringWithFormat:@"%@", userInfo];
    NSLog(@"%@",msg);
}


- (void)dealloc
{
    [super dealloc];
    [_window release];
    [_tabBarController release];
}

@end

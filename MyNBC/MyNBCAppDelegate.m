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
    
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                         | UIUserNotificationTypeBadge
                                                                                         | UIUserNotificationTypeSound) categories:nil];
    [application registerUserNotificationSettings:settings];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *strDeviceToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                                ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                                ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                                ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSString *strURL = [NSString stringWithFormat:@"https://api.northamptonboroughcouncil.com/mycouncil		/v1/enablePushNotifications?DeviceToken=%@", strDeviceToken];
    [request setURL:[NSURL URLWithString:strURL]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"wWGkCs1PTe1oUCLGGI9Cs69kZCkGy1Zb1LXg8mNY" forHTTPHeaderField:@"x-api-key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[deviceToken description] forKey:@"DeviceID"];
    [defaults synchronize];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //application.applicationIconBadgeNumber++;
}


- (void)dealloc
{
    [super dealloc];
    [_window release];
    [_tabBarController release];
}

@end

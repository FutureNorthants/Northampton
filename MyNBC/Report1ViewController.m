//
//  Report1ViewController.m
//  MyNBC
//
//  Created by Kevin White on 04/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report1ViewController.h"
#import "Report5ViewController.h"


@implementation Report1ViewController

@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    self.navigationItem.title=@"What is the problem?";
        
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
        [problemPicker setCenter:CGPointMake(160,220)];
        [button setCenter:CGPointMake(160,418)];
    }
    else // 3.5 inch
    {
        [button setCenter:CGPointMake(160,330)];
    }
        
    problemDescriptionArray = [[NSMutableArray alloc] init];
    problemNumberArray = [[NSMutableArray alloc] init];

    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Problems" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];   
    NSDictionary *entityProperties = [entity propertiesByName];
    [fetchRequest setReturnsDistinctResults:true];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:[entityProperties objectForKey:@"ProblemDescription"],[entityProperties objectForKey:@"ProblemNumber"], nil]];    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"ProblemDescription" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects){
        [problemDescriptionArray addObject:[info valueForKey:@"ProblemDescription"]];
        [problemNumberArray addObject:[info valueForKey:@"ProblemNumber"]];
    }
    [fetchRequest release];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)submitProblemType:(id)sender{  
    
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:[problemNumberArray objectAtIndex:[problemPicker selectedRowInComponent:0]] forKey:@"ProblemNumber"];    
    [defaults synchronize]; 
 
    Report5ViewController *vcReport5 = [[Report5ViewController alloc] initWithNibName:@"Report5ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [backButton setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    }
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport5 animated:YES];
    [vcReport5 release];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [problemNumberArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [problemDescriptionArray objectAtIndex:row];
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyNBC" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    
    return _managedObjectModel; 
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyNBC.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)showAboutPage
{
    NSLog(@"pressed");
}

@end

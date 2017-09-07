//
//  ContactUs2ViewController.m
//  MyNBC
//
//  Created by Kevin White on 06/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ContactUs2ViewController.h"
#import "ContactUs3ViewController.h"


@implementation ContactUs2ViewController

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
    self.navigationItem.title=@"More specifically?";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) // 3.5 inch
    {
        [button setCenter:CGPointMake(160,330)];
    }
    
    if (screenBounds.size.height == 568) // 4 inch
    {
        [optionPicker setCenter:CGPointMake(160,220)];
        [button setCenter:CGPointMake(160,418)];
    }
    
    if (screenBounds.size.height == 667) // 4.7 inch
    {
        [optionPicker setCenter:CGPointMake(160,270)];
        [button setCenter:CGPointMake(188,468)];
    }
    
    if (screenBounds.size.height == 736) // 5.5 inch
    {
        [optionPicker setCenter:CGPointMake(160,300)];
        [button setCenter:CGPointMake(207,498)];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"ContactServiceArea"]){
        serviceArea=[defaults objectForKey:@"ContactServiceArea"];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.2] forState:UIControlStateHighlighted];
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    button.titleLabel.font  = [UIFont fontWithName:@"HelveticaNeue" size:32];
    
    sectionsExtArray = [[NSMutableArray alloc] init];
    sectionsIntArray = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ContactOptions" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSDictionary *entityProperties = [entity propertiesByName];
    [fetchRequest setReturnsDistinctResults:true];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:[entityProperties objectForKey:@"ServiceAreaExt"],
                                        [entityProperties objectForKey:@"SectionExt"],
                                        [entityProperties objectForKey:@"SectionInt"],
                                        nil]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"SectionExt" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ServiceAreaInt MATCHES %@", serviceArea];
    [fetchRequest setPredicate:predicate];
    [sortDescriptor release];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        [sectionsExtArray addObject:[info valueForKey:@"SectionExt"]];
        [sectionsIntArray addObject:[info valueForKey:@"SectionInt"]];
    }
    [fetchRequest release];
    [sectionsExtArray retain];
    [sectionsIntArray retain];
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
    
    return [sectionsExtArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sectionsExtArray objectAtIndex:row];
}

- (IBAction)submitSubject:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[sectionsIntArray objectAtIndex:[optionPicker selectedRowInComponent:0]] forKey:@"ContactSection"];
    [defaults synchronize];
    ContactUs3ViewController *vcContact3 = [[ContactUs3ViewController alloc] initWithNibName:@"ContactUs3ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcContact3 animated:YES];
    [vcContact3 release];
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
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

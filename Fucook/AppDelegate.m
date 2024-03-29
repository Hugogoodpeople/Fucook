//
//  AppDelegate.m
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "AppDelegate.h"
#import "Home.h"
#import "Globals.h"
#import "FucookIAPHelper.h"
#import "WebServiceSender.h"

@interface AppDelegate ()
{
    WebServiceSender * listaIdsInApps;
}

@end

@implementation AppDelegate


-(void)webserviceInApps
{
#warning colocar aqui o url correcto para poder abrir o webservice
    listaIdsInApps = [[WebServiceSender alloc] initWithUrl:@"defenir url aqui" method:@"" tag:1];
    listaIdsInApps.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    // aqui nao tenho de enviar nada por enquanto
    
    [listaIdsInApps sendDict:dict];
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error
{
 
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado da lista de inApps  =>  %@", result.description);
                
                
                
                break;
            }

        }
    }else
    {
        NSLog(@"webservice error %@", error.description);
    }

    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [FucookIAPHelper sharedInstance];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    // inicializar o globals

    [Globals setimagensTemp:[NSMutableArray new]];
    
    Home * cenas = [Home new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:cenas];
    [nav.view setFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.window makeKeyAndVisible];
    
    // para os cantos arredondados
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    view.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.97f];
    [nav.view addSubview:view];
    
    UIImageView * topo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgframetop"]];
    [topo setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10)];
    [nav.view addSubview:topo];
    
    UIImageView * fundo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgframedown"]];
    [fundo setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-10, [[UIScreen mainScreen] bounds].size.width, 10)];
    [nav.view addSubview:fundo];
    
    [nav.navigationBar setBackgroundImage:[UIImage new]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    [nav.navigationBar setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.97f]];
    
    [nav.navigationBar setShadowImage:[UIImage new]];
    
    
    [self.window setRootViewController:nav];
    
    return YES;
}

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Hugo-Freelance.Fucook" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Fucook" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Fucook.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)applicationWillFinishLaunching:(NSNotification *)notification
{
    // Locate the receipt
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    
    // Test whether the receipt is present at the above path
    if(![[NSFileManager defaultManager] fileExistsAtPath:[receiptURL path]])
    {
        // Validation fails
        exit(173);
    }
    
    // Proceed with further receipt validation steps
}

@end

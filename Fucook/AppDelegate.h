//
//  AppDelegate.h
//  Fucook
//
//  Created by Hugo Costa on 03/11/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// cenas marada para ir buscar cenas de fora
+ (AppDelegate *)sharedAppDelegate;


@end


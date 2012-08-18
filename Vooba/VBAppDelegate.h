//
//  VBAppDelegate.h
//  Vooba
//
//  Created by Ryan Wersal on 8/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

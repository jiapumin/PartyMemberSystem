//
//  BNAppDelegate.h
//  PartyMemberSystem
//
//  Created by jpm on 14-7-14.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

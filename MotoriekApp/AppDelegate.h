//
//  AppDelegate.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 15-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) CMMotionManager *motionManager;

// Core Data properties
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Core Data methods
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

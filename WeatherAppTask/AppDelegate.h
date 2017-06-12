//
//  AppDelegate.h
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


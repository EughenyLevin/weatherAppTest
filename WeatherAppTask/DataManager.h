//
//  DataManager.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Request.h"

@interface DataManager : NSObject

+(instancetype)sharedData;

-(NSManagedObjectContext*)getCurrentContext;

@end

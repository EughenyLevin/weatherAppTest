//
//  ServerManager.h
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CurrentLocation;

@interface ServerManager : NSObject

+(instancetype)sharedManager;

-(void)getWeatherForecastForLocation:(NSString*)locaiton onSuccess:(void (^)(CurrentLocation *))success onFailure:(void (^)(NSError *))failure;

@end

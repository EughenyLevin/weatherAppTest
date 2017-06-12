//
//  CurrentLocation.m
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation

-(CurrentLocation*)initWithData:(NSDictionary *)data{
    
    self = [super init];
    if (self) {
        
        self.latitude   = [NSString stringWithFormat:@"%@",[data objectForKey:@"lat"]];
        self.longtitude = [NSString stringWithFormat:@"%@",[data objectForKey:@"lon"]];
        self.city       = [data objectForKey:@"city"];
        self.temp       = [[data objectForKey:@"temp"]doubleValue];
        
    }
    return self;
    
}

-(NSString*)description{
    return [NSString stringWithFormat:
    @"Location: %@ ,lat: %@, lon: %@, temp: %1.2f",self.city,self.latitude,self.longtitude,self.temp];
}

@end

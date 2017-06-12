//
//  CurrentLocation.h
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    SunType,
    CloudsType,
    RainType,
    
}weatherType;

@interface CurrentLocation : NSObject

@property (strong,nonatomic) NSString *latitude;
@property (strong,nonatomic) NSString *longtitude;
@property (strong,nonatomic) NSString *city;
@property (assign,nonatomic) double  temp;
@property (assign,nonatomic) weatherType weatherType;

-(CurrentLocation*)initWithData:(NSDictionary*)data;

@end

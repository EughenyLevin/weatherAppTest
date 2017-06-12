//
//  ServerManager.m
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "CurrentLocation.h"

@interface ServerManager ()

@property (strong,nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation ServerManager

+(instancetype)sharedManager{
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [ServerManager new];
        
    });
    
    return manager;
    
}

-(id)init{
    
    if (self = [super init]) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
        self.sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:
                               [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/"]];
        
    }
    return self;
}

-(void)getWeatherForecastForLocation:(NSString*)locaiton onSuccess:(void (^)(CurrentLocation *))success onFailure:(void (^)(NSError *))failure{
    
    [self.sessionManager GET:
    [NSString stringWithFormat:@"weather?q=%@&appid=dfb922ad45c3a804ffd35ac0a5c94587",locaiton]
    parameters:nil
    progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Success!");
        NSLog(@"Response: %@",responseObject);
        NSDictionary *coordinatesDict = [responseObject objectForKey:@"coord"];
        NSDictionary *tempDict        = [responseObject objectForKey:@"main"];
        NSArray *weatherArr     = [responseObject objectForKey:@"weather"];
        NSDictionary *weatherInfo = [weatherArr objectAtIndex:0];
        
        NSString *lat  = [coordinatesDict objectForKey:@"lat"];
        NSString *lon  = [coordinatesDict objectForKey:@"lon"];
        NSString *city = [responseObject objectForKey:@"name"];
        NSString *temp  = [tempDict objectForKey:@"temp"];
        
        
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",
                                        lon,@"lon",
                                        city,@"city",
                                        temp, @"temp", nil];
        
        CurrentLocation *locationData =[[CurrentLocation alloc]initWithData:dataDictionary];
        weatherType weather;
        
        if ([[weatherInfo objectForKey:@"main"]isEqualToString:@"Clouds"]) {
            weather = CloudsType;
        }  else if ([[weatherInfo objectForKey:@"main"]isEqualToString:@"Rain"]){
            weather = RainType;
        }  else weather = SunType;
        
        locationData.weatherType = weather;
        
        NSLog(@"%@ %@ %@ %f",locationData.latitude,locationData.longtitude,locationData.city,locationData.temp);
        
        if (success) {
            success(locationData);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
}

@end

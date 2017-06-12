//
//  Request+CoreDataProperties.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "Request+CoreDataProperties.h"

@implementation Request (CoreDataProperties)

+ (NSFetchRequest<Request *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Request"];
}

@dynamic time;
@dynamic city;
@dynamic lat;
@dynamic lon;
@dynamic temp;
@dynamic weatherType;

@end

//
//  Request+CoreDataProperties.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "Request.h"


NS_ASSUME_NONNULL_BEGIN

@interface Request (CoreDataProperties)

+ (NSFetchRequest<Request *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *lat;
@property (nullable, nonatomic, copy) NSString *lon;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *temp;
@property (nullable, nonatomic, copy) NSString *weatherType;

@end

NS_ASSUME_NONNULL_END

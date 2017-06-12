//
//  AbstractEntity+CoreDataProperties.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "AbstractEntity+CoreDataProperties.h"

@implementation AbstractEntity (CoreDataProperties)

+ (NSFetchRequest<AbstractEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AbstractEntity"];
}


@end

//
//  AbstractEntity+CoreDataProperties.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "AbstractEntity.h"


NS_ASSUME_NONNULL_BEGIN

@interface AbstractEntity (CoreDataProperties)

+ (NSFetchRequest<AbstractEntity *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END

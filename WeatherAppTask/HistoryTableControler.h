//
//  HistoryTableControler.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "DataViewController.h"
#import "CurrentLocation.h"

@interface HistoryTableControler : DataViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

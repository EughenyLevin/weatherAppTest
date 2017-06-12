//
//  DataViewController.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"



@interface DataViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *fetchedTesultsController;

@property (strong,nonatomic) NSManagedObjectContext     *managedObjectContex;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

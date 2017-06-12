//
//  HistoryTableControler.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "HistoryTableControler.h"
#import "HistoyTVCell.h"
#import "SectionView.h"
#import "DetailViewController.h"

@interface HistoryTableControler ()

@end

@implementation HistoryTableControler

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContex = _managedObjectContex;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContex = [[DataManager sharedData]getCurrentContext];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"historyCell";
    HistoyTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[HistoyTVCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return sectionInfo.name;
    
}

#pragma mark - UITableViewDelegate -


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    SectionView *header = [SectionView new];
    header.titleLabel.text = sectionInfo.name;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return self.tableView.bounds.size.height/ 7;
    
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController // геттер fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request" inManagedObjectContext:self.managedObjectContex];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[dateDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContex sectionNameKeyPath:@"city" cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    
    return _fetchedResultsController;
}


-(void)configureCell:(HistoyTVCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    Request *request = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.lat = request.lat;
    cell.lon = request.lon;
    cell.temp = request.temp;
    cell.locationLabel.text = [NSString stringWithFormat:@"Город: %@",request.city];
    cell.timeLabel.text     = [NSString stringWithFormat:@"Дата: %@",request.time];
    cell.weatheLabel.text   = request.weatherType;
  
}




#pragma mark - Action Methods -

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark SegueActions

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    Request *curRequst = [_fetchedResultsController objectAtIndexPath:indexPath];
    vc.currentData = curRequst;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

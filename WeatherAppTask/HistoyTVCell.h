//
//  HistoyTVCell.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentLocation.h"


@interface HistoyTVCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatheLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong,nonatomic) NSString *lat;
@property (strong,nonatomic) NSString *lon;
@property (strong,nonatomic) NSString *temp;

@end

//
//  HistoyTVCell.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "HistoyTVCell.h"
#import "UICollectionGeoCell.h"


@implementation HistoyTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;
    
}


#pragma mark - Methods


-(void)generateTitle:(NSString**)title andCount:(NSString**)count forIndexPath:(NSIndexPath*)indexPath{
    
    
    NSArray *titles = @[@"Широта",@"Долгота",@"Темп-ра"];
    NSInteger index = 0;
    
    switch (indexPath.item) {
            
        case 0:
            *count = self.lat;
            index  = indexPath.item;
            break;
        case 1:
            *count = self.lon;
            index  = indexPath.item;
            break;
        case 2:
            *count = self.temp;
            index  = indexPath.item;
            break;
        default:
            break;
    }
    
    *title = [titles objectAtIndex:index];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"infoCell";
    
    UICollectionGeoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *title = [NSString string];
    NSString *count = [NSString string];
    
    [self generateTitle:&title andCount:&count forIndexPath:indexPath];
    
    cell.titleLabel.text  = title;
    cell.valueLabel.text = count;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [cell layoutIfNeeded];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*) collectionView.collectionViewLayout;
    
    double cellWidth = (CGRectGetWidth(collectionView.frame) - (flowLayout.sectionInset.left + flowLayout.sectionInset.right) - flowLayout.minimumInteritemSpacing) / 1.3;
    return CGSizeMake(cellWidth/3, cellWidth/3);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}



@end

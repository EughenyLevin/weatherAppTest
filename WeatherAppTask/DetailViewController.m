//
//  DetailViewController.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.cityField.text = self.currentData.city;
    self.weatherField.text = [NSString stringWithFormat:@"%@, +%@",self.currentData.weatherType,self.currentData.temp];
    self.geoData.text = [NSString stringWithFormat:@"Lat: %@, Lon: %@",self.currentData.lat,self.currentData.lon];
    self.timeField.text = [NSString stringWithFormat:@"%@",self.currentData.time];
    
}





- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

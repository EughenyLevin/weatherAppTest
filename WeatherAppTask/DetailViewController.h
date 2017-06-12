//
//  DetailViewController.h
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *weatherField;
@property (weak, nonatomic) IBOutlet UITextField *geoData;
@property (weak, nonatomic) IBOutlet UITextField *timeField;

@property (strong,nonatomic) Request *currentData;

@end

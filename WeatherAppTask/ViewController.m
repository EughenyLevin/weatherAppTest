//
//  ViewController.m
//  WeatherAppTask
//
//  Created by Evgheny on 10.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//
#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CurrentLocation.h"
#import "ServerManager.h"
#import "DataManager.h"

@interface ViewController ()

{
    
    CLLocationManager *locationManager;
}

@property (strong,nonatomic) CurrentLocation *currnetLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *lonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatheImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [super viewDidLoad];
    self.context = [[DataManager sharedData]getCurrentContext];
    
    _mapView.delegate = (id)self;
     self.mapView.showsUserLocation = YES;
    locationManager = [CLLocationManager new];
    locationManager.delegate = (id)self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
  
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    
    [self setBackgroundImage];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

}


-(void)setBackgroundImage{
    
    UIGraphicsBeginImageContext(self.bottomView.frame.size);
    [[UIImage imageNamed:@"weather"] drawInRect:self.bottomView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bottomView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

#pragma MKMapViewDelegate

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
  
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       for (__unused CLPlacemark *placemark in placemarks) {
                           
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                          
                           if (placemark.locality != nil) {
                            
                               NSLog(@"City:  %@",placemark.locality);
                               [self weatherForecastForLocation:placemark.locality];
                           }
                       }
                    }];
}

#pragma mark ForecastRequset


-(void)weatherForecastForLocation:(NSString*)location {
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        [[ServerManager sharedManager]getWeatherForecastForLocation:location onSuccess:^(CurrentLocation * curLoc) {
            
            __weak typeof(self) weakSelf = self;
            
            weakSelf.currnetLocation = curLoc;
            [weakSelf saveLocationDataToRequest];
            [weakSelf updateViewWithNewLocation];
            
        } onFailure:^(NSError * error) {
            
        }];

        
    });
}

#pragma mark saveData

-(void)saveLocationDataToRequest{
    
    Request *newRequest = [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:self.context];
    newRequest.lat  = self.currnetLocation.latitude;
    newRequest.lon  = self.currnetLocation.longtitude;
    newRequest.city = self.currnetLocation.city;
    double t = self.currnetLocation.temp - 270;
    newRequest.temp = [NSString stringWithFormat:@"+%1.2f",t];
    
    switch (self.currnetLocation.weatherType) {
        case RainType:
            newRequest.weatherType = @"Дождь";
            break;
        case CloudsType:
            newRequest.weatherType = @"Облачно";
            break;
        case SunType:
            newRequest.weatherType = @"Солнечно";
            break;
        default:
            break;
    }
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"hh:mm-dd-MM-yyyy"];
    newRequest.time = [df stringFromDate:[NSDate date]];
    [self.context save:nil];
}

-(void)updateViewWithNewLocation{
    
    self.cityLabel.text = self.currnetLocation.city;
    self.latLabel.text  = [NSString stringWithFormat:@"Lat: %@",self.currnetLocation.latitude];
    self.lonLabel.text  = [NSString stringWithFormat:@"Lon: %@",self.currnetLocation.longtitude];
    double temp = self.currnetLocation.temp - 270.0;
    self.tempLabel.text = [NSString stringWithFormat:@"+%1.1f",temp];
    
    switch (self.currnetLocation.weatherType) {
        case RainType:
            self.weatheImageView.image = [UIImage imageNamed:@"rain"];
            break;
        case CloudsType:
            self.weatheImageView.image = [UIImage imageNamed:@"clouds"];
            break;
        case SunType:
            self.weatheImageView.image = [UIImage imageNamed:@"sun"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

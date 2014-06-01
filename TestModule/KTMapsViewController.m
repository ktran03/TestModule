//
//  KTMapsViewController.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTMapsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "KTPlaceMark.h"

#define ZOOM_LEVEL 2000
#define KEY_SEARCH_TERM @"restaurant";

@interface KTMapsViewController ()
@end

@implementation KTMapsViewController
@synthesize currentLocation = _currentLocation;

#pragma mark - VC init & life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _mapView.showsUserLocation = YES;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)setCurrentLocation:(CLLocation *)currentLocation{
    _currentLocation = currentLocation;
    MKCoordinateRegion locationRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, ZOOM_LEVEL, ZOOM_LEVEL);
    MKCoordinateRegion zoomedRegion = [_mapView regionThatFits:locationRegion];
    [_mapView setRegion:zoomedRegion animated:YES];
    [self findNearbyLocationsInRegion:zoomedRegion];
}

#pragma mark - Core location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (_currentLocation == nil) {
        [self setCurrentLocation:[locations lastObject]];
    }
}

#pragma mark - Map View helper
-(void)findNearbyLocationsInRegion:(MKCoordinateRegion)region{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = KEY_SEARCH_TERM;
    request.region = region;
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        NSMutableArray *placemarks = [NSMutableArray new];
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop) {
            KTPlaceMark *placemark = [[KTPlaceMark alloc] initWithPlacemark:item.placemark];
            [placemarks addObject:placemark];
        }];
        
        [_mapView addAnnotations:placemarks];
        
    }];
}



@end

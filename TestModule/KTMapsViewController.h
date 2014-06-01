//
//  KTMapsViewController.h
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KTMapsViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

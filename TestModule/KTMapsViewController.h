//
//  KTMapsViewController.h
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface KTMapsViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

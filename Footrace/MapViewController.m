//
//  MapViewController.m
//  Footrace
//
//  Created by Nick Hu on 13-11-4.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "AccuracyLocationMananger.h"
@implementation RGAnnotion
@synthesize coordinate = _coordinate;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
    }
    return self;
}
@end

@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController

@synthesize map;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.map.showsUserLocation = YES;
    for (NSArray *locs in [AccuracyLocationMananger sharedInstance].todayLocArray) {
        for (CLLocation *l in locs) {
            RGAnnotion *a = [[RGAnnotion alloc] init];
            a.coordinate = l.coordinate;
            [self.map addAnnotation:a];
        }
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *AnnotationViewIdentifier = @"AnnotationView";
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewIdentifier];
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    return pin;
}
@end

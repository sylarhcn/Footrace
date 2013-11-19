//
//  MapViewController.h
//  Footrace
//
//  Created by Nick Hu on 13-11-4.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RGAnnotion : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end


@interface MapViewController : UIViewController<MKMapViewDelegate>

@end

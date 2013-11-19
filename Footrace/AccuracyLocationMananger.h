//
//  AccuracyLocationMananger.h
//  Footrace
//
//  Created by Nick Hu on 13-11-6.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

#define kAccuracyLocationData @"AccuracyLocationData"

@interface AccuracyLocationMananger : NSObject <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *todayLocArray;
@property (nonatomic,strong) NSMutableDictionary *allLocDic;
+ (AccuracyLocationMananger*)sharedInstance;
- (void)startAccuracyLocation;
@end

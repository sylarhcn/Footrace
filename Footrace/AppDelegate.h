//
//  AppDelegate.h
//  Footrace
//
//  Created by Nick Hu on 13-11-4.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define kMapData @"mapdata"
#define NotificationDidUpdateLocations @"didUpdateLocations"

@protocol UpdateLocDelegate <NSObject>

- (void)locUpadte:(NSArray*)array time:(NSTimeInterval)time;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationMananger;
@property (strong, nonatomic) NSMutableArray *todayMapDataArray;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIStoryboard *mainStoryboard;
@property (strong, nonatomic) NSMutableDictionary *mapDataDic;
+ (AppDelegate *)sharedAppDelegate;
@end

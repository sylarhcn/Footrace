//
//  AppDelegate.m
//  Footrace
//
//  Created by Nick Hu on 13-11-4.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "AppDelegate.h"
#import "RecentViewController.h"
#import "AccuracyLocationMananger.h"
#import "RGTools.h"
@implementation AppDelegate

#pragma mark - appDelegate
+ (AppDelegate *)sharedAppDelegate {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.locationMananger = [[CLLocationManager alloc] init];
    self.locationMananger.delegate = self;
    [self.locationMananger startMonitoringSignificantLocationChanges];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kMapData];
    self.mapDataDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.todayMapDataArray = [self.mapDataDic objectForKey:[RGTools todayByString]];
    if (self.todayMapDataArray == nil) {
        self.todayMapDataArray = [NSMutableArray array];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [self.locationMananger stopMonitoringSignificantLocationChanges];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    [self.locationMananger startUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSString *key = [RGTools todayByString];
    if ([self.mapDataDic objectForKey:key] != nil) {
        [self.mapDataDic removeObjectForKey:key];
    }
    [self.mapDataDic setObject:self.todayMapDataArray forKey:key];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.mapDataDic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kMapData];
    
    if ([[AccuracyLocationMananger sharedInstance].allLocDic objectForKey:key] != nil) {
        [[AccuracyLocationMananger sharedInstance].allLocDic removeObjectForKey:key];
    }
    [[AccuracyLocationMananger sharedInstance].allLocDic setObject:[AccuracyLocationMananger sharedInstance].todayLocArray forKey:key];
    
    NSData *accuracyData = [NSKeyedArchiver archivedDataWithRootObject:[AccuracyLocationMananger sharedInstance].allLocDic];
    [[NSUserDefaults standardUserDefaults] setObject:accuracyData forKey:kAccuracyLocationData];   
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [[AccuracyLocationMananger sharedInstance] startAccuracyLocation];
    BOOL isSameDay = NO;
    NSDate *now = [NSDate date];
    for (int i = 0; i < self.todayMapDataArray.count; i++) {
        CLLocation *loc = [[self.todayMapDataArray objectAtIndex:i] objectAtIndex:0];
        isSameDay = [RGTools isSameDayWithDate1:now date2:loc.timestamp];
        if (isSameDay) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:[self.todayMapDataArray objectAtIndex:i]];
            [array addObjectsFromArray:locations];
            [self.todayMapDataArray removeObjectAtIndex:i];
            [self.todayMapDataArray insertObject:array atIndex:i];
            break;
        }
    }

    if (!isSameDay) {
        [self.todayMapDataArray addObject:locations];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDidUpdateLocations object:self];
}

@end

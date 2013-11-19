//
//  AccuracyLocationMananger.m
//  Footrace
//
//  Created by Nick Hu on 13-11-6.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "AccuracyLocationMananger.h"
#import "RGTools.h"
#define locationSpanTime 5
@interface AccuracyLocationMananger()
@property (strong,nonatomic) NSTimer *stopTimer;
@property (assign,nonatomic) NSTimeInterval startLocationTime;
@property (assign,nonatomic) NSTimeInterval lastUpdateTime;
@end

@implementation AccuracyLocationMananger
+ (AccuracyLocationMananger*)sharedInstance
{
    static AccuracyLocationMananger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kAccuracyLocationData];
        self.allLocDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.todayLocArray = [self.allLocDic objectForKey:[RGTools todayByString]];
        if (self.todayLocArray == Nil) {
            self.todayLocArray = [NSMutableArray array];
        }
    }
    return self;
}

- (void)startAccuracyLocation
{
    [self.locationManager startUpdatingLocation];
    self.lastUpdateTime = self.startLocationTime = [NSDate timeIntervalSinceReferenceDate];
    if ([self.stopTimer isValid]) {
        [self.stopTimer invalidate];
    }
    self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shouldStopLocation) userInfo:Nil repeats:YES];
}

- (void)shouldStopLocation
{
    NSLog(@"timer");
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if ((now - self.lastUpdateTime)>locationSpanTime || (now - self.startLocationTime)>3*locationSpanTime) {
        [self.locationManager stopUpdatingHeading];
        [self.stopTimer invalidate];
        self.stopTimer = Nil;
        if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground) {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"o_O" message:@"精准定位关闭" delegate:nil cancelButtonTitle:@"X" otherButtonTitles:nil, nil];
            [view show];
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];
    BOOL isSameDay = NO;
    NSDate *now = [NSDate date];
    for (int i = 0; i < self.todayLocArray.count; i++) {
        CLLocation *loc = [[self.todayLocArray objectAtIndex:i] objectAtIndex:0];
        isSameDay = [self isSameDayWithDate1:now date2:loc.timestamp];
        if (isSameDay) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:[self.todayLocArray objectAtIndex:i]];
            [array addObjectsFromArray:locations];
            [self.todayLocArray removeObjectAtIndex:i];
            [self.todayLocArray insertObject:array atIndex:i];
            break;
        }
    }
    
    if (!isSameDay) {
        [self.todayLocArray addObject:locations];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDidUpdateLocations object:self];
}


- (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end

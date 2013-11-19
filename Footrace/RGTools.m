//
//  RGTools.m
//  Footrace
//
//  Created by Nick Hu on 13-11-7.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "RGTools.h"

@implementation RGTools

#pragma mark - tools
+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (NSString*)todayByString
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString*)yesterdayBeforeDate:(NSDate*)date
{
    return @"";
}

+ (NSString*)tommorowAfterDate:(NSDate*)date
{
    return @"";
}
@end

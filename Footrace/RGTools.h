//
//  RGTools.h
//  Footrace
//
//  Created by Nick Hu on 13-11-7.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGTools : NSObject

+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString*)todayByString;
@end

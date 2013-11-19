//
//  PersistentStack.h
//  Footrace
//
//  Created by Nick Hu on 13-11-13.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//TODO: what this class do?
@interface PersistentStack : NSObject;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@end

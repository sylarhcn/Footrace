//
//  Item.h
//  Footrace
//
//  Created by Nick Hu on 13-11-18.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) Item *parent;
+ (instancetype)insertItemWithTitle:(NSString*)title
                             parent:(Item*)parent
             inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSFetchedResultsController*)childrenFetchedResultsController;
@end


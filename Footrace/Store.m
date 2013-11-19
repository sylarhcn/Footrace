//
//  Store.m
//  Footrace
//
//  Created by Nick Hu on 13-11-18.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "Store.h"

@implementation Store
- (Item *)rootItem
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@",nil];
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:NULL];
    Item *rootItem = [objects lastObject];
    if (rootItem == nil) {
        rootItem = [Item insertItemWithTitle:nil parent:nil
                      inManagedObjectContext:self.managedObjectContext];
    }
    return rootItem;
}
@end

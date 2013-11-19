//
//  Store.h
//  Footrace
//
//  Created by Nick Hu on 13-11-18.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
@interface Store : NSObject
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
- (Item*)rootItem;
@end

//
//  PersistentStack.m
//  Footrace
//
//  Created by Nick Hu on 13-11-13.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "PersistentStack.h"

@interface PersistentStack ()
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSURL *modelURL;
@property (nonatomic,strong) NSURL *storeURL;
@end

@implementation PersistentStack
@synthesize managedObjectContext;

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:Nil URL:self.storeURL options:Nil error:&error];
    if (error) {
        NSLog(@"error: %@",error);
    }
}

- (NSManagedObjectModel*)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}
@end

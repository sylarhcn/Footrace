//
//  FetchResultsControllerDataSource.h
//  Footrace
//
//  Created by Nick Hu on 13-11-18.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@protocol FetchedResultsControllerDataSourceDelegate <NSObject>

- (void)configureCell:(id)cell wihtObject:(id)object;
- (void)deleteObject:(id)object;

@end

@interface FetchResultsControllerDataSource : NSObject <UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, assign) id<FetchedResultsControllerDataSourceDelegate> delegate;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, assign) BOOL paused;
- (id)initWithTableView:(UITableView*)tableView;
- (id)selectedItem;
@end


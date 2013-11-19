//
//  RecentViewController.h
//  Footrace
//
//  Created by Nick Hu on 13-11-5.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "Item.h"
#import "FetchResultsControllerDataSource.h"
@interface RecentViewController : UITableViewController<CLLocationManagerDelegate,FetchedResultsControllerDataSourceDelegate,UITextFieldDelegate>
@property (nonatomic, strong) Item *parent;
@end

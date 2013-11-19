//
//  DayListViewController.h
//  Footrace
//
//  Created by Nick Hu on 13-11-11.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayListViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

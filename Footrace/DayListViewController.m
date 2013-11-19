//
//  DayListViewController.m
//  Footrace
//
//  Created by Nick Hu on 13-11-11.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "DayListViewController.h"
#import "RecentViewController.h"
@interface DayListViewController ()
@property (nonatomic,strong) NSMutableArray *viewContorllers;
@property (nonatomic,assign) NSInteger index;
@end

@implementation DayListViewController
@synthesize viewContorllers,index = _index;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewContorllers = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [self.viewContorllers addObject:[NSNull null]];
    }
    self.scrollView.contentSize = CGSizeMake(self.viewContorllers.count * CGRectGetWidth(self.scrollView.frame), self.scrollView.contentSize.height);
    self.scrollView.delaysContentTouches = YES;
    self.index = 0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%d",index]];
    [self loadContentView:index - 1];
    [self loadContentView:index];
    [self loadContentView:index + 1];
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * index;
    bounds.origin.y = 0;
//    bounds.size.height = 1;
//    [self.scrollView scrollRectToVisible:bounds animated:NO];
}

- (void)loadContentView:(NSInteger)pageIndex
{
    if (pageIndex > self.viewContorllers.count - 1 || pageIndex < 0) {
        return;
    }
    UITableView  *table = [self.viewContorllers objectAtIndex:pageIndex%3];
    if ((NSNull*)table == [NSNull null]) {
        table = [[UITableView alloc] init];
        table.delegate = self;
        table.dataSource = self;
        [self.viewContorllers replaceObjectAtIndex:pageIndex%3 withObject:table];
    }
//    RecentViewController *controller = [self.viewContorllers objectAtIndex:pageIndex%3];
//    if ((NSNull*)controller == [NSNull null]) {
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//        controller = [sb instantiateViewControllerWithIdentifier:@"RecentViewController"];
//        [self.viewContorllers replaceObjectAtIndex:pageIndex%3 withObject:controller];
//    }
    table.tag = pageIndex;
    [table reloadData];
    CGRect frame = self.scrollView.frame;
    frame.origin.x = pageIndex * CGRectGetWidth(self.scrollView.frame);
    table.frame = frame;
    if (table.superview == nil) {
        [self.scrollView addSubview:table];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    self.index = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"recentLocCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",tableView.tag];
    return cell;
}
@end

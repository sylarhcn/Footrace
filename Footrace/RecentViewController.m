//
//  RecentViewController.m
//  Footrace
//
//  Created by Nick Hu on 13-11-5.
//  Copyright (c) 2013年 Nick Hu. All rights reserved.
//

#import "RecentViewController.h"
#import "FetchResultsControllerDataSource.h"
static NSString* const selectItemSegue = @"selectItem";

@interface RecentViewController ()
@property (nonatomic, strong) FetchResultsControllerDataSource *fetchResultsControllerDataSource;
@property (nonatomic, strong) UITextField *titleField;
@end

@implementation RecentViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFetchedResultsController];
    [self setupNewItemField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        
    }
    self.fetchResultsControllerDataSource.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.fetchResultsControllerDataSource.paused = YES;
}

- (void)setupFetchedResultsController
{
    self.fetchResultsControllerDataSource = [[FetchResultsControllerDataSource alloc] initWithTableView:self.tableView];
    self.fetchResultsControllerDataSource.fetchedResultsController = self.parent.childrenFetchedResultsController;//TODO: why?
    self.fetchResultsControllerDataSource.delegate = self;
    self.fetchResultsControllerDataSource.reuseIdentifier = @"Cell";
}

- (void)setupNewItemField
{
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.tableView.rowHeight)];
    self.titleField.delegate = self;
    self.titleField.placeholder = NSLocalizedString(@"Add a new item", @"Placeholder text for adding a new item");
    self.tableView.tableHeaderView = self.titleField;
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:selectItemSegue]) {
        
    }
}

- (void)presentSbuItemViewController:(RecentViewController*)subItemViewController
{
    Item *item = [self.fetchResultsControllerDataSource selectedItem];
    subItemViewController.parent = item;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *title = textField.text;
    NSString *actionName = [NSString stringWithFormat:NSLocalizedString(@"add item \"%@\"", @"Undo aciton name of add item"),title];
    [self.undoManager setActionName:actionName];
    [Item insertItemWithTitle:title parent:self.parent inManagedObjectContext:self.managedObjectContext];
    textField.text = @"";
    [textField resignFirstResponder];
    return NO;
}

- (NSManagedObjectContext*)managedObjectContext
{
    return self.parent.managedObjectContext;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (-scrollView.contentOffset.y > self.titleField.bounds.size.height) {
        
    }
    else if (scrollView.contentOffset.y > 0) {
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    BOOL itemFieldVisible = self.tableView.contentInset.top == 0;
    if (itemFieldVisible) {
        [self.titleField becomeFirstResponder];
    }
}

- (void)showNewItemField
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = -self.titleField.bounds.size.height;
    self.tableView.contentInset = insets;
}

- (void)hideNewItemField
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = -self.titleField.bounds.size.height;
    self.tableView.contentInset = insets;
}

- (void)setParent:(Item *)parent
{
    _parent = parent;
    self.navigationItem.title = parent.title;
}

#pragma mark - Undo
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (NSUndoManager *)undoManager
{
    return self.managedObjectContext.undoManager;
}
@end

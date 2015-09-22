//
//  ViewController.m
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/21/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import "AcromineViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "LongFormObject.h"
#import "NetworkManager.h"

static NSString * const cellIdentifier = @"longFormCell";

@interface AcromineViewController ()
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation AcromineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSearchController];
    [self setupSearchBar];
}

- (void)setupSearchController {
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
}

- (void)setupSearchBar {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, 320, 44)];
    searchBar.scopeButtonTitles = @[NSLocalizedString(@"ScopeButtonMusic",@"Song")];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    
    __weak __typeof__(self) weakSelf = self;
    NetworkManager *manager = [NetworkManager sharedInstance];
    [self showHUD];
    
    [manager getSearchResultsForSearchText:searchBar.text successBlock:^(NSArray *results) {
        
        __typeof__(self) strongSelf = weakSelf;
        strongSelf.searchResults = results;
        [strongSelf.tableView reloadData];
        [strongSelf hideHUD];
        
    } failureBlock:^(NSError *error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in searching" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

#pragma mark - MBProgressHUD

- (void)showHUD {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    LongFormObject *object = self.searchResults[indexPath.row];
    
    cell.textLabel.text = object.longForm;
    return cell;
}

@end

//
//  ViewController.h
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/21/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * @brief  This class displays the search results.
 */
@interface AcromineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

/*
 * @brief  The `UISearchController` object
 */
@property (strong, nonatomic) UISearchController *searchController;

/*
 * @brief  The `UITableView` object
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


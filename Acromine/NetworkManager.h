//
//  NetworkManager.h
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/21/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/*
 * @brief  This class provides convinence methods to request results for search text
 */
@interface NetworkManager : NSObject

/*
 * @brief  Use this method to create a shared instance of `NetworkManager` class
 */
+ (instancetype)sharedInstance;

/*
 * @brief  Use this method to get results for the search text
 *
 * @warning  The successBlock and failureBlocks are required
 *
 * @param  successBlock, The successBlock to be called on main queue.
 * @param  failureBlock, The failureBlock to be called on main queue.
 */
- (void)getSearchResultsForSearchText:(NSString *)searchText
                         successBlock:(void (^)(NSArray *))successBlock
                         failureBlock:(void (^)(NSError *))failureBlock;

@end

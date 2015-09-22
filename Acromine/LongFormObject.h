//
//  LongFormObject.h
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/22/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * @brief  This is a concrete class to represent Long Forms
 */
@interface LongFormObject : NSObject

/*
 * @brief  The long form string
 */
@property (strong, nonatomic) NSString *longForm;

/*
 * @brief  Use this method to create `LongFormObject` from values dictionary
 *
 * @param  The values dictionary passed in
 */
- (instancetype)initWithValuesDictionary:(NSDictionary *)valuesDictionary;

@end

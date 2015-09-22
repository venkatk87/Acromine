//
//  LongFormObject.m
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/22/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import "LongFormObject.h"

@implementation LongFormObject

- (instancetype)initWithValuesDictionary:(NSDictionary *)valuesDictionary {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _longForm = valuesDictionary[@"lf"];
    return self;
}

@end

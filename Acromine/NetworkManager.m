//
//  NetworkManager.m
//  Acromine
//
//  Created by Venkatesh Kadiyala on 9/21/15.
//  Copyright (c) 2015 Venkatesh Kadiyala. All rights reserved.
//

#import "NetworkManager.h"
#import "LongFormObject.h"

static NSString *const baseURLString = @"http://www.nactem.ac.uk/";

@implementation NetworkManager

+ (instancetype)sharedInstance {
    
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[NetworkManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)getSearchResultsForSearchText:(nonnull NSString *)searchText
                         successBlock:(void (^)(NSArray *))successBlock
                         failureBlock:(void (^)(NSError *))failureBlock {
    
    
    NSParameterAssert(searchText);
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];

    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *jsonAcceptableContentTypes = [NSMutableSet setWithSet:jsonResponseSerializer.acceptableContentTypes];
    [jsonAcceptableContentTypes addObject:@"text/plain"];
    jsonResponseSerializer.acceptableContentTypes = jsonAcceptableContentTypes;
    sessionManager.responseSerializer = jsonResponseSerializer;
    
    NSDictionary *parameters = @{@"sf":searchText};
    
    __weak __typeof__(self) weakSelf = self;
    NSURLSessionDataTask *task = [sessionManager GET:@"software/acromine/dictionary.py"
                                          parameters:parameters
                                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                                 
                                                 __typeof__(self) strongSelf = weakSelf;
                                                 NSArray *responseArray = (NSArray *)responseObject;
                                                 [strongSelf longFormObjectsFromResponse:responseArray successBlock:^(NSArray *responseArray){
                                                        successBlock(responseArray);
                                                 }];
                                                 
                                           } failure:^(NSURLSessionDataTask *task, NSError *error){
                                               
                                               failureBlock(error);
                                           }];
    
    [task resume];
}

- (void)longFormObjectsFromResponse:(NSArray *)responseArray
                       successBlock:(void (^)(NSArray *))successBlock {
    
    
    __block NSMutableArray *lfsObjects = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSDictionary *dictionary in responseArray) {
            
            NSArray *lfsValues = dictionary[@"lfs"];
            for (NSDictionary *lfsValuesDictionary in lfsValues) {
                
                LongFormObject *object = [[LongFormObject alloc] initWithValuesDictionary:lfsValuesDictionary];
                [lfsObjects addObject:object];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            successBlock(lfsObjects);
        });
    });
}

@end

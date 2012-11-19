//
//  VBVoobaClient.h
//  Vooba
//
//  Created by Ryan Wersal on 11/19/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "AFHTTPClient.h"

@interface VBVoobaClient : AFHTTPClient

- (void)boardPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

+ (VBVoobaClient*)sharedClient;

@end

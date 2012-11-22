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
- (void)commentsForTopic:(NSNumber*)topicID withBlock:(void (^)(NSArray *comments, NSError *error))block;
- (void)loginWithEmail:(NSString*)email password:(NSString*)password andBlock:(void (^)(NSError *error))block;

- (BOOL)userLoggedIn;

+ (VBVoobaClient*)sharedClient;

@end

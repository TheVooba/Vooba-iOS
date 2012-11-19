//
//  VBVoobaClient.m
//  Vooba
//
//  Created by Ryan Wersal on 11/19/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBVoobaClient.h"

@implementation VBVoobaClient

#pragma mark - Vooba API Calls

- (void)boardPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                             VOOBA_APP_TOKEN, @"appToken",
                             @"e4951e957440c49d52f512c7f64cadfae60e33a15f0f5f1bbc3114712a3c3921", @"userToken",
                             @0, @"start",
                             @500, @"end",
                             @"20100101", @"afterDate", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=getBoardPosts" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block)
        {
            block([[[responseObject objectForKey:@"theFeed"] objectAtIndex:0] objectForKey:@"data"], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block([NSArray array], error);
        }
    }];
}

#pragma mark - AFHTTPClient Configuration

+ (VBVoobaClient*)sharedClient
{
    static VBVoobaClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[VBVoobaClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://vooba.net/api/"]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self == nil) return nil;
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end

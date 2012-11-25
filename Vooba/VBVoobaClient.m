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

- (void)newBoardPostWithMessage:(NSString *)message andBlock:(void (^)(NSError *error))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            [NSUserDefaults userToken], @"userToken",
                            message, @"message",
                            [NSUserDefaults userID], @"userID", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=newBoardPost" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block)
        {
            // Need to handle the various status codes.
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(error);
        }
    }];
}

- (void)newCommentOnTopic:(NSNumber *)topicID withMessage:(NSString *)message andBlock:(void (^)(NSError *))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            [NSUserDefaults userToken], @"userToken",
                            message, @"comment",
                            topicID, @"topicID", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=newBoardComment" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block)
        {
            // Need to handle the various status codes.
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(error);
        }
    }];
}

- (void)commentsForTopic:(NSNumber*)topicID withBlock:(void (^)(NSArray *, NSError *))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            [NSUserDefaults userToken], @"userToken",
                            topicID, @"topicID",
                            @"20100101", @"afterDate", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=getBoardComments" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block)
        {
            block([[[responseObject objectForKey:@"boardComments"] objectAtIndex:0] objectForKey:@"data"], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block([NSArray array], error);
        }
    }];
}

- (void)boardPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                             VOOBA_APP_TOKEN, @"appToken",
                             [NSUserDefaults userToken], @"userToken",
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

- (void)loginWithEmail:(NSString*)email password:(NSString*)password andBlock:(void (^)(NSError *error))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            email, @"email",
                            password, @"password", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [NSUserDefaults setUserID:responseObject[@"user"][@"userID"]];
        [NSUserDefaults setUserToken:[responseObject objectForKey:@"userToken"]];
        
        if (block)
        {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       if (block)
       {
           block(error);
       }
    }];
}

- (void)logoutWithBlock:(void (^)(NSError *))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            [NSUserDefaults userToken], @"userToken", nil];
    [[VBVoobaClient sharedClient] postPath:@"api.php?act=logout" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [NSUserDefaults setUserID:nil];
        [NSUserDefaults setUserToken:nil];
        
        if (block)
        {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(error);
        }
    }];
}

#pragma mark - Helpers

- (BOOL)userLoggedIn
{
    return ([[NSUserDefaults userToken] length] > 0);
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

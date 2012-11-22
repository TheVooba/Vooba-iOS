//
//  VBVoobaClient.m
//  Vooba
//
//  Created by Ryan Wersal on 11/19/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBVoobaClient.h"

@interface VBVoobaClient ()

@property (nonatomic, strong) NSString *userToken;

@end

@implementation VBVoobaClient

#pragma mark - Vooba API Calls

- (void)boardPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                             VOOBA_APP_TOKEN, @"appToken",
                             self.userToken, @"userToken",
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
        self.userToken = [responseObject objectForKey:@"userToken"];
        
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

#pragma mark - Properties 

- (NSString *)userToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
}

- (void)setUserToken:(NSString *)userToken
{
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Helpers

- (BOOL)userLoggedIn
{
    return ([self.userToken length] > 0);
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

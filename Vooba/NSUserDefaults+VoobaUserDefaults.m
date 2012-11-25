//
//  NSUserDefaults+VoobaUserDefaults.m
//  Vooba
//
//  Created by Ryan Wersal on 11/24/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "NSUserDefaults+VoobaUserDefaults.h"

@implementation NSUserDefaults (VoobaUserDefaults)

static NSString* const kDefaultsUserID = @"userID";
+ (NSString *)userID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsUserID];
}
+ (void)setUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kDefaultsUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static NSString* const kDefaultsUserToken = @"userToken";
+ (NSString *)userToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsUserToken];
}
+ (void)setUserToken:(NSString *)userToken
{
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:kDefaultsUserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

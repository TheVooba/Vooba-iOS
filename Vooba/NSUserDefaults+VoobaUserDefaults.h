//
//  NSUserDefaults+VoobaUserDefaults.h
//  Vooba
//
//  Created by Ryan Wersal on 11/24/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (VoobaUserDefaults)

+ (NSString*)userToken;
+ (void)setUserToken:(NSString*)userToken;

+ (NSString*)userID;
+ (void)setUserID:(NSString*)userID;

@end

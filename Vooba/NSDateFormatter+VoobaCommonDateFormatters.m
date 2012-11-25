//
//  NSDateFormatter+VoobaCommonDateFormatters.m
//  Vooba
//
//  Created by Ryan Wersal on 11/24/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "NSDateFormatter+VoobaCommonDateFormatters.h"

@implementation NSDateFormatter (VoobaCommonDateFormatters)

+ (NSDateFormatter *)boardDateFormatter
{
    static NSDateFormatter *_boardDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _boardDateFormatter = [[NSDateFormatter alloc] init];
        [_boardDateFormatter setDateFormat: @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+00:00'"]; // 2012-11-20T23:11:54+00:00
    });
    return _boardDateFormatter;
}

@end

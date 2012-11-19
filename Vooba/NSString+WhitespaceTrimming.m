//
//  NSString+WhitespaceTrimming.m
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "NSString+WhitespaceTrimming.h"

@implementation NSString (WhitespaceTrimming)

- (NSString *)stringByTrimmingLeadingWhitespace
{
    NSRange range = [self rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
    return [self stringByReplacingCharactersInRange:range withString:@""];
}

- (NSString *)stringByTrimmingTrailingWhitespace
{
    NSRange range = [self rangeOfString:@"\\s*$" options:NSRegularExpressionSearch];
    return [self stringByReplacingCharactersInRange:range withString:@""];
}

- (NSString *)stringByTrimmingWhitespace
{
    NSString *str = [self stringByTrimmingLeadingWhitespace];
    str = [str stringByTrimmingTrailingWhitespace];
    return str;
}

@end

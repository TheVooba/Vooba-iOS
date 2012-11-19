//
//  NSString+WhitespaceTrimming.h
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WhitespaceTrimming)

- (NSString*)stringByTrimmingLeadingWhitespace;
- (NSString*)stringByTrimmingTrailingWhitespace;
- (NSString*)stringByTrimmingWhitespace;

@end

//
//  VBTableViewCell.m
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBTableViewCell.h"

@implementation VBTableViewCell

+ (id)cellForTableView:(UITableView *)tableView
{
    return [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
}

+(NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (id)init
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VBTableViewCell cellIdentifier]];
}

@end

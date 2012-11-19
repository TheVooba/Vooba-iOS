//
//  VBNewFriendCell.h
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBTableViewCell.h"

@interface VBNewFriendCell : VBTableViewCell

+ (CGFloat)height;

- (void)setWhoName:(NSString*)who andWithName:(NSString*)with;

@end

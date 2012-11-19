//
//  VBNewFriendCell.m
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBNewFriendCell.h"

@interface VBNewFriendCell ()

@property (nonatomic, strong) UILabel *lblContent;

@end

@implementation VBNewFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    VBNewFriendCell *cell = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (cell != nil)
    {
        self.lblContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
        [self.lblContent setMinimumScaleFactor:12];
        [self.lblContent setNumberOfLines:1];
        [self.lblContent setFont:[UIFont systemFontOfSize:12]];
        
        [cell.contentView addSubview:self.lblContent];
    }
    return cell;
}

- (void)setWhoName:(NSString *)who andWithName:(NSString *)with
{
    self.lblContent.text = [NSString stringWithFormat:@"%@ is now friends with %@.",
                            [who stringByTrimmingWhitespace],
                            [with stringByTrimmingWhitespace], nil];
}

+ (CGFloat)height
{
    return 20 + 15;
}

@end

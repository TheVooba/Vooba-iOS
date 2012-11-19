//
//  VBNewPhotoAlbumCell.m
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBNewPhotoAlbumCell.h"

@interface VBNewPhotoAlbumCell ()

@property (nonatomic, strong) UILabel* lblContent;

@end

@implementation VBNewPhotoAlbumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    VBNewPhotoAlbumCell *cell = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (void)setName:(NSString *)name
{
    self.lblContent.text = [NSString stringWithFormat:@"%@ uploaded a new photo album.", name, nil];
}

+ (CGFloat)height
{
    return 20 + 15;
}

@end

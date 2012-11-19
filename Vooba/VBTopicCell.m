//
//  VBPostCell.m
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBTopicCell.h"

@interface VBTopicCell ()

@property (nonatomic, strong) UIImageView *imgAvatar;
@property (nonatomic, strong) UILabel* lblName;
@property (nonatomic, strong) TTTAttributedLabel* lblText;

@end

@implementation VBTopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        self.imgAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [self.imgAvatar setContentMode:UIViewContentModeScaleAspectFit];
        
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 245, 15)];
        [self.lblName setMinimumScaleFactor:12];
        [self.lblName setFont:[UIFont boldSystemFontOfSize:12]];
        
        self.lblText = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        [self.lblText setLineBreakMode:NSLineBreakByWordWrapping];
        [self.lblText setMinimumScaleFactor:12];
        [self.lblText setNumberOfLines:0];
        [self.lblText setFont:[UIFont systemFontOfSize:12]];
        [self.lblText setDataDetectorTypes:UIDataDetectorTypeLink];
        
        [self.contentView addSubview:self.imgAvatar];
        [self.contentView addSubview:self.lblName];
        [self.contentView addSubview:self.lblText];
    }    
    return self;
}

- (void)setAvatarURL:(NSURL*)url;
{
    [self.imgAvatar setImageWithURL:url];
}

- (void)setFromName:(NSString *)fromName andToName:(NSString *)toName
{
    if ([fromName isEqualToString:toName])
    {
        self.lblName.text = [fromName stringByTrimmingWhitespace];
    }
    else
    {
        self.lblName.text = [NSString stringWithFormat:@"%@ to %@",
                             [fromName stringByTrimmingWhitespace],
                             [toName stringByTrimmingWhitespace], nil];
    }
}

- (void)setComment:(NSString *)comment
{
    self.lblText.text = [comment stringByTrimmingWhitespace];
    self.lblText.frame = CGRectMake(65, 30, 245, [VBTopicCell heightForCommentLabelWithContent:comment]);
}

+ (CGFloat)heightForCommentLabelWithContent:(NSString*)content
{
    CGSize constraint = CGSizeMake(255, 20000);
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:12]
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 10;
}

+ (CGFloat)heightWithContent:(NSString *)content
{
    CGFloat height = MAX([VBTopicCell heightForCommentLabelWithContent:content] + 30, 60);
    return height + 10;
}

@end

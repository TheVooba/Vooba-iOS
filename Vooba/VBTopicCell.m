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
@property (nonatomic, strong) UILabel* lblDate;

@end

@implementation VBTopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    self.imgAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self.imgAvatar setContentMode:UIViewContentModeScaleAspectFit];
    
    self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 245, 15)];
    [self.lblName setMinimumScaleFactor:12];
    [self.lblName setFont:[UIFont boldSystemFontOfSize:12]];
    [self.lblName setBackgroundColor:[UIColor clearColor]];
    
    self.lblText = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    [self.lblText setLineBreakMode:NSLineBreakByWordWrapping];
    [self.lblText setMinimumScaleFactor:12];
    [self.lblText setNumberOfLines:0];
    [self.lblText setFont:[UIFont systemFontOfSize:12]];
    [self.lblText setDataDetectorTypes:UIDataDetectorTypeLink];
    [self.lblText setBackgroundColor:[UIColor clearColor]];
    [self.lblText setDelegate:self];
    
    self.lblDate = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.lblDate setMinimumScaleFactor:11];
    [self.lblDate setFont:[UIFont systemFontOfSize:11]];
    [self.lblDate setTextAlignment:NSTextAlignmentRight];
    [self.lblDate setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView addSubview:self.imgAvatar];
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.lblText];
    [self.contentView addSubview:self.lblDate];
    
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
    [self setNeedsLayout];
}

- (void)setDate:(NSDate *)date
{
    if (date == nil) return;
    
    NSString* pretty_date = [MHPrettyDate prettyDateFromDate:date withFormat:MHPrettyDateShortRelativeTime];
    self.lblDate.text = pretty_date;
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
    return height + 20;
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([self.delegate respondsToSelector:@selector(cell:didSelectLinkWithURL:)])
    {
        [self.delegate cell:self didSelectLinkWithURL:url];
    }
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgAvatar.frame = CGRectMake(10, 10, 50, 50);
    self.lblName.frame = CGRectMake(65, 10, 245, 15);
    
    CGRect textFrame = CGRectOffset(self.lblName.frame, 0, self.lblName.frame.size.height);
    textFrame.size.height = [VBTopicCell heightForCommentLabelWithContent:self.lblText.text];
    self.lblText.frame = textFrame;
    
    CGRect dateFrame = CGRectOffset(self.lblText.frame, 0, textFrame.size.height);
    dateFrame.size = self.lblName.frame.size;
    self.lblDate.frame = dateFrame;
}

@end

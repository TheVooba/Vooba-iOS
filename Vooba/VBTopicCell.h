//
//  VBPostCell.h
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBTableViewCell.h"

@interface VBTopicCell : VBTableViewCell

+ (CGFloat)heightWithContent:(NSString*)content;
+ (CGFloat)heightForCommentLabelWithContent:(NSString*)content;

- (void)setAvatarURL:(NSURL*)url;
- (void)setFromName:(NSString*)fromName andToName:(NSString*)toName;
- (void)setComment:(NSString*)comment;

@end

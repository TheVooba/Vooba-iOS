//
//  VBCommentsViewController.h
//  Vooba
//
//  Created by Ryan Wersal on 11/21/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VBTopicCell.h"

@interface VBCommentsViewController : UITableViewController <VBTopicCellDelegate>

@property (nonatomic, strong) NSDictionary *topicData;

@end

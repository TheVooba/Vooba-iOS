//
//  VBTableViewCell.h
//  Vooba
//
//  Created by Ryan Wersal on 11/18/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBTableViewCell : UITableViewCell

+ (id)cellForTableView:(UITableView*)tableView;
+ (NSString*)cellIdentifier;

- (id)init;

@end

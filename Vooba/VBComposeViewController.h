//
//  VBComposeViewController.h
//  Vooba
//
//  Created by Ryan Wersal on 11/22/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeTypePost,
    ComposeTypeComment
} ComposeType;

@interface VBComposeViewController : UIViewController

@property (nonatomic, strong) NSNumber *topicID;

@end

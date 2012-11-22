//
//  VBComposeViewController.m
//  Vooba
//
//  Created by Ryan Wersal on 11/22/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBComposeViewController.h"

@interface VBComposeViewController ()

@property (nonatomic, strong) UITextView IBOutlet *textView;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation VBComposeViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];	
    [self.textView becomeFirstResponder];
}

#pragma mark - Events

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done:(id)sender
{
    if (self.topicID == nil)
    {
        [[VBVoobaClient sharedClient] newBoardPostWithMessage:self.textView.text andBlock:^(NSError *error) {
            if (error != nil)
            {
                NSLog(@"%@", error);
            }
        }];
    }
    else
    {
        [[VBVoobaClient sharedClient] newCommentOnTopic:self.topicID withMessage:self.textView.text andBlock:^(NSError *error) {
            if (error != nil)
            {
                NSLog(@"%@", error);
            }
        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

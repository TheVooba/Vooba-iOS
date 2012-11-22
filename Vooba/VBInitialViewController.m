//
//  VBInitialViewController.m
//  Vooba
//
//  Created by Ryan Wersal on 11/19/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBInitialViewController.h"

@interface VBInitialViewController ()

@end

@implementation VBInitialViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIViewController *vc = nil;
    // Do we have a valid userToken?
    if (![[VBVoobaClient sharedClient] userLoggedIn])
    {
        vc = [[UIStoryboard storyboardWithName:@"iPhone-Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];
    }
    else
    {
        vc = [[UIStoryboard storyboardWithName:@"iPhone-Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Board"];
    }
    [self presentViewController:vc animated:NO completion:nil];
}

@end

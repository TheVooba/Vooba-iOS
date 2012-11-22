//
//  VBLoginViewController.m
//  Vooba
//
//  Created by Ryan Wersal on 11/19/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBLoginViewController.h"

@interface VBLoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtPassword;

- (void)handleLogin;

@end

@implementation VBLoginViewController

#pragma mark - UIView

- (void)viewDidLoad
{
    [self.txtEmail becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtEmail)
    {
        [self.txtPassword becomeFirstResponder];
    }
    else if (textField == self.txtPassword)
    {
        [self handleLogin];
    }
    return YES;
}

- (void)handleLogin
{
    [[VBVoobaClient sharedClient] loginWithEmail:self.txtEmail.text password:self.txtPassword.text andBlock:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"%@", error);
        }
        else
        {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

@end

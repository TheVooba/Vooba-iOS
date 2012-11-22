//
//  VBCommentsViewController.m
//  Vooba
//
//  Created by Ryan Wersal on 11/21/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBCommentsViewController.h"
#import "VBComposeViewController.h"

#import "VBTopicCell.h"

@interface VBCommentsViewController ()

@property (nonatomic, strong) NSArray *commentData;

- (void)refresh;

- (IBAction)compose:(id)sender;

@end

@implementation VBCommentsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Comments";
    
    // Register cell identifiers
    [self.tableView registerClass:[VBTopicCell class] forCellReuseIdentifier:[VBTopicCell cellIdentifier]];
    
    // Configure pull to refresh.
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self refresh];
}

- (void)refresh
{
    [[VBVoobaClient sharedClient] commentsForTopic:self.topicData[@"topicID"] withBlock:^(NSArray *comments, NSError *error) {
        if (error == nil)
        {
            self.commentData = comments;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Events

- (IBAction)compose:(id)sender
{
    VBComposeViewController *composeVC = [[UIStoryboard storyboardWithName:@"iPhone-Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Compose"];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [composeVC setTopicID:self.topicData[@"topicID"]];
    [self presentViewController:composeVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:[VBTopicCell cellIdentifier] forIndexPath:indexPath];
    NSDictionary *data = [self.commentData objectAtIndex:[indexPath row]];
    
    [cell setFromName:data[@"name"] andToName:data[@"name"]];
    [cell setComment:data[@"comment"]];
    [cell setAvatarURL:[NSURL URLWithString:data[@"avatar"]]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentData count];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VBTopicCell *cell = [VBTopicCell new];
    [cell setFromName:self.topicData[@"from"][@"name"] andToName:self.topicData[@"to"][@"name"]];
    [cell setComment:self.topicData[@"comment"]];
    
    NSString *avatarPath = self.topicData[@"from"][@"avatar"];
    [cell setAvatarURL:[NSURL URLWithString:avatarPath]];
    
    [cell setBackgroundColor:[UIColor grayColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [VBTopicCell heightWithContent:self.topicData[@"comment"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSDictionary *data = [self.commentData objectAtIndex:[indexPath row]];
    return [VBTopicCell heightWithContent:data[@"comment"]];
}

@end

//
//  VBBoardViewController.m
//  Vooba
//
//  Created by Ryan Wersal on 10/22/12.
//  Copyright (c) 2012 Ryan Wersal. All rights reserved.
//

#import "VBBoardViewController.h"

#import "VBTopicCell.h"
#import "VBNewFriendCell.h"
#import "VBNewPhotoAlbumCell.h"

@interface VBBoardViewController ()

@property (nonatomic, strong) NSArray *postData;

- (void)refresh;

@end

#pragma mark - UIViewController

@implementation VBBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell identifiers
    [self.tableView registerClass:[VBTopicCell class] forCellReuseIdentifier:[VBTopicCell cellIdentifier]];
    [self.tableView registerClass:[VBNewFriendCell class] forCellReuseIdentifier:[VBNewFriendCell cellIdentifier]];
    [self.tableView registerClass:[VBNewPhotoAlbumCell class] forCellReuseIdentifier:[VBNewPhotoAlbumCell cellIdentifier]];
    
    // Configure Pull to Refresh.
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self refresh];
}

- (void)refresh
{
    [[VBVoobaClient sharedClient] boardPostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error == nil)
        {
            self.postData = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VBTableViewCell *cell = nil;
    
    NSDictionary *data = [self.postData objectAtIndex:[indexPath row]];
    NSNumber *post_type = data[@"type"];
    if ([post_type integerValue] == 0) // Topic
    {
        VBTopicCell *topic_cell = [tableView dequeueReusableCellWithIdentifier:[VBTopicCell cellIdentifier] forIndexPath:indexPath];
        
        [topic_cell setFromName:data[@"from"][@"name"] andToName:data[@"to"][@"name"]];
        [topic_cell setComment:data[@"comment"]];
        
        NSString *avatarPath = data[@"from"][@"avatar"];
        [topic_cell setAvatarURL:[NSURL URLWithString:avatarPath]];
        
        cell = topic_cell;
    }
    else if ([post_type integerValue] == 1) // Like a Board
    {
        
    }
    else if ([post_type integerValue] == 2) // New Friends
    {
        VBNewFriendCell *friend_cell = [tableView dequeueReusableCellWithIdentifier:[VBNewFriendCell cellIdentifier] forIndexPath:indexPath];
        
        [friend_cell setWhoName:data[@"who"][@"name"] andWithName:data[@"with"][@"name"]];
        
        cell = friend_cell;
    }
    else if ([post_type integerValue] == 3) // New Photo Album
    {
        VBNewPhotoAlbumCell *photo_album_cell = [tableView dequeueReusableCellWithIdentifier:[VBNewPhotoAlbumCell cellIdentifier] forIndexPath:indexPath];
        
        [photo_album_cell setName:data[@"user"][@"name"]];
        
        cell = photo_album_cell;
    }
    
    // Defaulting for now until the other cell types are done.
    if (cell == nil)
    {
        cell = [VBTableViewCell new];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postData count];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    NSDictionary *data = [self.postData objectAtIndex:[indexPath row]];
    NSNumber *post_type = data[@"type"];
    if ([post_type integerValue] == 0) // Topic
    {
        height = [VBTopicCell heightWithContent:data[@"comment"]];
    }
    else if ([post_type integerValue] == 1) // Like a Board Post
    {
        
    }
    else if ([post_type integerValue] == 2) // New Friends
    {
        height = [VBNewFriendCell height];
    }
    else if ([post_type integerValue] == 3) // New Photo Album
    {
        height = [VBNewPhotoAlbumCell height];
    }
    
    return height;
}

@end

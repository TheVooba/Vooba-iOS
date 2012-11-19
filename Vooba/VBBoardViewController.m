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

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *postData;

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
    
    // Temporary API calls - these need a better home
    __block NSString *userToken = nil;
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://vooba.net/api/"]];
    
    // Login
    NSDictionary *loginParams = [NSDictionary dictionaryWithObjectsAndKeys:
                            VOOBA_APP_TOKEN, @"appToken",
                            @"ryanwersal@gmail.com", @"email",
                            @"JOxtxRGLS9fpMX5rotTDrAFbwvqTIh", @"password", nil];
    NSURLRequest *loginRequest = [client requestWithMethod:@"POST" path:@"api.php?act=login" parameters:loginParams];
    AFJSONRequestOperation *loginOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:loginRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        userToken = [JSON objectForKey:@"userToken"];
    } failure:nil];
    
    // Get Board Posts
    NSDictionary *boardParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 VOOBA_APP_TOKEN, @"appToken",
                                 @"e4951e957440c49d52f512c7f64cadfae60e33a15f0f5f1bbc3114712a3c3921", @"userToken",
                                 @0, @"start",
                                 @500, @"end",
                                 @"20100101", @"afterDate", nil];
    NSURLRequest *boardRequest = [client requestWithMethod:@"POST" path:@"api.php?act=getBoardPosts" parameters:boardParams];
    AFJSONRequestOperation *boardOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:boardRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        self.postData = [[[JSON objectForKey:@"theFeed"] objectAtIndex:0] objectForKey:@"data"];
        [self.tableView reloadData];
    } failure:nil];
    [boardOperation addDependency:loginOperation];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue setMaxConcurrentOperationCount:1];
    [queue addOperation:loginOperation];
    [queue addOperation:boardOperation];
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

//
//  FavoriteTableViewController.m
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import "FavoriteTableViewController.h"

@interface FavoriteTableViewController ()

@end

@implementation FavoriteTableViewController

static NSString * const refreshTableViewNotification = @"refreshNotification";
static NSString * const reuseIdentifier = @"videoCell";
static NSString * const emptyImage = @"empty";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VideoTabBarController *tabBarController = (VideoTabBarController *)self.tabBarController;
    self.favoriteVideos = tabBarController.favoriteVideos;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:refreshTableViewNotification object:nil];
    
    [self retrieveFavoriteVideos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retrieveFavoriteVideos {
    NSArray *favorites = [VideoHelper retrieveFavorites];
    for (NSDictionary *videoInfo in favorites) {
        NSString *title = videoInfo[@"title"];
        NSString *videoId = videoInfo[@"videoId"];
        NSString *desc = videoInfo[@"desc"];
        NSString *thumbnailURL = videoInfo[@"thumbnailURL"];
        Video *video = [[Video alloc] initWithTitle:title desc:desc videoId:videoId thumbnailURL:thumbnailURL];
        [self.favoriteVideos addObject:video];
    }
}

- (void)updateTable {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favoriteVideos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    Video *video = self.favoriteVideos[indexPath.row];
    cell.titleLabel.text = video.title;
    [cell.playerView loadWithVideoId:video.videoId];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.favoriteVideos removeObjectAtIndex:indexPath.row];
        [VideoHelper saveFavorites:self.favoriteVideos];
        [tableView reloadData];
    }
}

#pragma mark - DZNEmptyDataSet data source
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.favoriteVideos.count == 0;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:emptyImage];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"No Favorite Videos";
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"To get started, favorite a video from the Video tab.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end

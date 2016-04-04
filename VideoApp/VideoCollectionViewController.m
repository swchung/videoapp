//
//  VideoCollectionViewController.m
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import "VideoCollectionViewController.h"

@interface VideoCollectionViewController ()

@end

@implementation VideoCollectionViewController

static NSString * const refreshTableViewNotification = @"refreshNotification";
static NSString * const reuseIdentifier = @"videoCell";
static NSString * const placeholderImage = @"placeholder";

static NSString * const youtubeAPIKey = @"AIzaSyC-wH3KbiWUqwzkDzlikRz7xd-eCPiI0gk";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    LineLayout *flowLayout = [[LineLayout alloc] init];
    [self.collectionView setCollectionViewLayout:flowLayout];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    flowLayout.minimumInteritemSpacing = CGFLOAT_MAX;
//    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.youtubeVideos = [NSMutableArray array];
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Favorite Video" action:@selector(favoriteAction:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:menuItem]];

    [self fetchPopularVideos];
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)) {
//        [self.menuCollectionView setCollectionViewLayout:self.landscapeLayout animated:YES];
//    } else {
//        [self.menuCollectionView setCollectionViewLayout:self.portraitLayout animated:YES];
//    }
//}

- (void)favoriteAction:(id)sender forCell:(VideoCollectionViewCell *)cell {
    VideoTabBarController *tabBarController = (VideoTabBarController *)self.tabBarController;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    Video *video = (Video *)(self.youtubeVideos[indexPath.row]);
    [tabBarController.favoriteVideos insertObject:video atIndex:0];
    [VideoHelper saveFavorites:tabBarController.favoriteVideos];
    [[NSNotificationCenter defaultCenter] postNotificationName:refreshTableViewNotification object:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPopularVideos {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    NSString *youtubeAPIEndpoint = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?chart=mostPopular&key=%@&part=snippet&maxResults=50", youtubeAPIKey];
    
    NSURL *url = [[NSURL alloc] initWithString:youtubeAPIEndpoint];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSDictionary *items = jsonResult[@"items"];
            for (NSDictionary *item in items) {
                NSDictionary *snippet = item[@"snippet"];
                NSString *title = snippet[@"title"];
                NSString *desc = snippet[@"description"];
                NSString *videoId = item[@"id"];
                NSString *thumbnailURL = snippet[@"thumbnails"][@"medium"][@"url"];
                Video *video = [[Video alloc] initWithTitle:title desc:desc videoId:videoId thumbnailURL:thumbnailURL];
                [self.youtubeVideos addObject:video];
            }
        } else {
            NSLog(@"Error retrieving data from server");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            [self.collectionView reloadData];
        });
    }] resume];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.youtubeVideos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollectionViewCell *cell = (VideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    Video *video = self.youtubeVideos[indexPath.row];
    [cell.playerView loadWithVideoId:video.videoId];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	NSLog(@"performAction");
}

#pragma mark - UIMenuController required methods
- (BOOL)canBecomeFirstResponder {
    return YES;
}


@end

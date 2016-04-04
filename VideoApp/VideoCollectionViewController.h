//
//  VideoCollectionViewController.h
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

#import "VideoCollectionViewCell.h"
#import "VideoTabBarController.h"
#import "Video.h"
#import "VideoHelper.h"
#import "LineLayout.h"
//#import "UIImage+Helpers.h"

@interface VideoCollectionViewController : UICollectionViewController <UIWebViewDelegate, MyMenuDelegate>
@property (nonatomic, strong, readwrite) NSMutableArray *youtubeVideos;
@end

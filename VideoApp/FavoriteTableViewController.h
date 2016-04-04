//
//  FavoriteTableViewController.h
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import "VideoTabBarController.h"
#import "VideoTableViewCell.h"
#import "VideoHelper.h"

@interface FavoriteTableViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, weak, readwrite) NSMutableArray *favoriteVideos;

@end

//
//  VideoCollectionViewCell.h
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@class VideoCollectionViewCell;

@protocol MyMenuDelegate <NSObject>
@optional
- (void)favoriteAction:(id)sender forCell:(VideoCollectionViewCell *)cell;
@end

@interface VideoCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) id<MyMenuDelegate> delegate;
@end

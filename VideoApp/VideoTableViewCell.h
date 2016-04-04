//
//  VideoTableViewCell.h
//  VideoApp
//
//  Created by Steven Chung on 4/1/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;

@end

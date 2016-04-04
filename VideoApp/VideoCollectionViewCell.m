//
//  VideoCollectionViewCell.m
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    }
    return self;
}

- (void)favoriteAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(favoriteAction:forCell:)]) {
        [self.delegate favoriteAction:sender forCell:self];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(favoriteAction:)) {
        return YES;
    }
    return NO;
}

@end

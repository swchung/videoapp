//
//  Video.m
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import "Video.h"

@implementation Video

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc videoId:(NSString *)videoId thumbnailURL:(NSString *)thumbnailURL {
    self = [super init];
    if (self) {
        _title = title;
        _desc = desc;
        _videoId = videoId;
        _thumbnailURL = thumbnailURL;
    }
    return self;
}
- (NSDictionary *)getInfo {
    return @{
        @"title": self.title,
        @"desc": self.desc,
        @"videoId": self.videoId,
        @"thumbnailURL": self.thumbnailURL
    };
}

@end

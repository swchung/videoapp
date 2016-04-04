//
//  VideoHelper.m
//  VideoApp
//
//  Created by Steven Chung on 4/1/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import "VideoHelper.h"

@implementation VideoHelper


+ (BOOL)saveFavorites:(NSArray *)videos {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *favoritesPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"favorites.plist"];
    NSMutableArray *content = [NSMutableArray array];
    for (Video *video in videos) {
        [content addObject:[video getInfo]];
    }
    [content writeToFile:favoritesPlistPath atomically:YES];
    return YES;
}

+ (NSArray *)retrieveFavorites {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *favoritesPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"favorites.plist"];
    return [[NSArray alloc] initWithContentsOfFile:favoritesPlistPath];
}

@end

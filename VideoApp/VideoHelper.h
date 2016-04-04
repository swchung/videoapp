//
//  VideoHelper.h
//  VideoApp
//
//  Created by Steven Chung on 4/1/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

@interface VideoHelper : NSObject
+ (BOOL)saveFavorites:(NSArray *)videos;
+ (NSArray *)retrieveFavorites;
@end

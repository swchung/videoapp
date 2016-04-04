//
//  Video.h
//  VideoApp
//
//  Created by Steven Chung on 3/31/16.
//  Copyright © 2016 Steven Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *desc;
@property (nonatomic, strong, readwrite) NSString *videoId;
@property (nonatomic, strong, readwrite) NSString *thumbnailURL;
- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc videoId:(NSString *)videoId thumbnailURL:(NSString *)thumbnailURL;
- (NSDictionary *)getInfo;
@end

//
//  YYImageCache+ZDGroupIconCache.m
//  CodeGeass
//
//  Created by ec on 2017/4/20.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "YYImageCache+ZDGroupIconCache.h"

@implementation YYImageCache (ZDGroupIconCache)

+ (instancetype)groupIconCache
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        cachePath = [cachePath stringByAppendingPathComponent:@"com.ibireme.yykit"];
        cachePath = [cachePath stringByAppendingPathComponent:@"groupIcon"];
        instance = [[self alloc] initWithPath:cachePath];
    });
    return instance;
}

@end

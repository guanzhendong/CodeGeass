//
//  ZDUserInfoApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/16.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDUserInfoApi.h"

@implementation ZDUserInfoApi

- (NSString *)requestUrl {
    return @"api/user/getinfo";
}

- (NSInteger)cacheTimeInSeconds {
    return kZDHttpCacheTimeOneHour;
}

- (id)requestArgument {
    return @{};
}

@end

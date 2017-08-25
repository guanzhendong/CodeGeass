//
//  ZDQQFriendApi.m
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDQQFriendApi.h"

@implementation ZDQQFriendApi {
    NSInteger _page;
}

- (instancetype)initWithPage:(NSInteger)page {
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/qq/friends";
}

- (id)requestArgument {
    return @{
             @"page" : @(_page)
             };
}

@end

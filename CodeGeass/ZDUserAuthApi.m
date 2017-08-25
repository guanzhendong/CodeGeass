//
//  ZDUserAuthApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/19.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDUserAuthApi.h"

@implementation ZDUserAuthApi

- (NSString *)requestUrl {
    return @"api/auth/func";
}

- (id)requestArgument {
    return @{};
}

@end

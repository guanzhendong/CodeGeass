//
//  ZDSessionListApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDSessionListApi.h"

@implementation ZDSessionListApi {
    NSInteger _timestamp;
}

- (instancetype)initWithTimestamp:(NSInteger)timestamp
{
    self = [super init];
    if (self) {
        _timestamp = timestamp;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"msg/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"UserID" : @([ZDUserManager sharedManager].userModel.Id.integerValue),
             @"Key"    : [ZDUserManager sharedManager].userModel.key,
             @"Type"   : @(_timestamp == 0 ? 0 : 1),
             @"Time"   : @(_timestamp)
             };
}

@end

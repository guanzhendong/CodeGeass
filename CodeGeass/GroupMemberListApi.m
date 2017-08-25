//
//  GroupMemberListApi.m
//  ECLite
//
//  Created by ec on 16/6/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "GroupMemberListApi.h"

@interface GroupMemberListApi ()
@property (nonatomic, copy  ) NSString  *groupId;
@property (nonatomic, assign) NSInteger timestamp;
@end

@implementation GroupMemberListApi

- (instancetype)initWithGroupId:(NSString *)groupId
                      timestamp:(NSInteger)timestamp
{
    self = [super init];
    if (self) {
        _groupId = groupId;
        _timestamp = timestamp;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/group/groupmemberurl";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSInteger)cacheTimeInSeconds {// 如果API是拉变更的，这不需要设置使用缓存，每次都真正发起请求
    return kZDHttpCacheTimeOneMinute;
}

- (id)requestArgument {
    return @{@"UserID"  : @([ZDUserManager sharedManager].userModel.Id.integerValue),
             @"GroupID" : @(_groupId.integerValue),
             @"Time"    : @(_timestamp),
             @"Key"     : [ZDUserManager sharedManager].userModel.key};
}

@end

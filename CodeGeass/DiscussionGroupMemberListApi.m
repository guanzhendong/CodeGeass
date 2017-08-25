//
//  DiscussionGroupMemberListApi.m
//  ECLite
//
//  Created by ec on 16/6/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "DiscussionGroupMemberListApi.h"

@interface DiscussionGroupMemberListApi ()
@property (nonatomic, copy  ) NSString  *discussionGroupId;
@property (nonatomic, assign) NSInteger timestamp;
@end

@implementation DiscussionGroupMemberListApi

- (instancetype)initWithDiscussionGroupId:(NSString *)discussionGroupId
                                timestamp:(NSInteger)timestamp;
{
    self = [super init];
    if (self) {
        _discussionGroupId = discussionGroupId;
        _timestamp         = timestamp;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/discuss/dismemberurl";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSInteger)cacheTimeInSeconds {
    return kZDHttpCacheTimeOneMinute;
}

- (id)requestArgument {
    return @{@"UserID"  : @([ZDUserManager sharedManager].userModel.Id.integerValue),
             @"Discuss" : @(_discussionGroupId.integerValue),
             @"Time"    : @(_timestamp),
             @"Key"     : [ZDUserManager sharedManager].userModel.key};
}

@end

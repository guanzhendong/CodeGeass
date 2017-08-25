//
//  BatchDiscussionGroupBasicInfoApi.m
//  ECLite
//
//  Created by ec on 16/7/4.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "BatchDiscussionGroupBasicInfoApi.h"

@interface BatchDiscussionGroupBasicInfoApi ()

@property (nonatomic, assign) NSInteger batch;

@end

@implementation BatchDiscussionGroupBasicInfoApi

- (instancetype)initWithBatch:(NSInteger)batch {
    self = [super init];
    if (self) {
        self.batch = batch;
    }
    return self;
}

- (NSString *)baseUrl {
    return HTTP_HOST;
}

- (NSString *)requestUrl {
    return @"/v2/discuss/batchdis";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSInteger)cacheTimeInSeconds {
    return kZDHttpCacheTimeOneHour;
}

- (id)requestArgument {
    return @{
             @"UserID" : @([ZDUserManager sharedManager].userModel.Id.integerValue),
             @"Batch"  : @(_batch),
             @"Key"    : [ZDUserManager sharedManager].userModel.key
             };
}
@end

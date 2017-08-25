//
//  BatchGroupBasicInfoApi.m
//  ECLite
//
//  Created by ec on 16/7/4.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "BatchGroupBasicInfoApi.h"

@interface BatchGroupBasicInfoApi ()

@property (nonatomic, assign) NSInteger batch;

@end

@implementation BatchGroupBasicInfoApi

- (instancetype)initWithBatch:(NSInteger)batch {
    self = [super init];
    if (self) {
        _batch = batch;
    }
    return self;
}

- (NSString *)baseUrl {
    return  HTTP_HOST;
}

- (NSString *)requestUrl {
    return @"/v2/group/batchgroup";
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

//
//  ZDGetSMSVerificationCodeApi.m
//  CodeGeass
//
//  Created by ec on 2018/11/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "ZDGetSMSVerificationCodeApi.h"

@implementation ZDGetSMSVerificationCodeApi {
    NSString *_account;
    NSInteger _type;
    NSInteger _platform;
    NSString *_machineCode;
}

- (instancetype)initWithAccount:(NSString *)account type:(NSInteger)type {
    self = [super init];
    if (self) {
        _account = account;
        _type = type;
        _platform = 6;
        _machineCode = [[NSString stringWithUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"v1/verify/messageask";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"Account" : _account,
             @"Type" : @(_type),
             @"Platform" : @(_platform),
             @"MachineCode" : _machineCode
             };
}

@end

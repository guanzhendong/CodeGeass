//
//  ZDVerifySMSCodeApi.m
//  CodeGeass
//
//  Created by ec on 2018/11/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "ZDVerifySMSCodeApi.h"

@implementation ZDVerifySMSCodeApi {
    NSString *_account;
    NSInteger _type;
    NSString *_machinecode;
    NSInteger _platform;
    NSInteger _version;
    NSString *_verifyid;
    NSString *_machineName;
    NSString *_machineType;
}

- (instancetype)initWithAccount:(NSString *)account type:(NSInteger )type verifyid:(NSString *)verifyid{
    self = [super init];
    if (self) {
        _account = account;
        _type = type;
        _machinecode = [[NSString stringWithUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _platform = 6;
        _version = 7500;
        _verifyid = verifyid;
        _machineName = [UIDevice currentDevice].name;
        _machineType = [NSString stringWithFormat:@"%@ %@ %@",[UIDevice currentDevice].machineModelName,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"v1/verify/messageverify";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"Account" : StringFromObject(_account),
             @"Type" : @(_type),
             @"MachineCode" : _machinecode,
             @"Platform" : @(_platform),
             @"Version" : @(_version),
             @"Verifyid" : StringFromObject(_verifyid),
             @"MachineName" : _machineName,
             @"MachineType" : _machineType
             };
}

@end

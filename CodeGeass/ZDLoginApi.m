//
//  ZDLoginApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDLoginApi.h"

@implementation ZDLoginApi {
    NSString *_account;
    NSString *_password;
    NSInteger _timeStamp;
    NSString *_machinecode;
    NSInteger _platform;
    NSInteger _version;
    NSString *_secretKey;
    NSString *_machineName;
    NSString *_machineType;
}

- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password {
    self = [super init];
    if (self) {
        _account = account;
        _secretKey = [YYKeychain getPasswordForService:[[UIApplication sharedApplication].appBundleName stringByAppendingString:@"_SecreKey"] account:account];
        if (IsEmptyObject(_secretKey)) {
            _password = [password md5String];
        }
        _timeStamp = [[NSDate date] timeIntervalSince1970];
        _machinecode = [[NSString stringWithUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _platform = 6;
        _version = 7500;
        _machineName = [UIDevice currentDevice].name;
        _machineType = [NSString stringWithFormat:@"%@ %@ %@",[UIDevice currentDevice].machineModelName,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"v1/loginverify/login";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"UserAccount" : StringFromObject(_account),
             @"Password"    : StringFromObject(_password),
             @"TimeStamp"   : @(_timeStamp),
             @"MachineCode" : _machinecode,
             @"Platform"    : @(_platform),
             @"Version"     : @(_version),
             @"SecreKey"    : StringFromObject(_secretKey),
             @"MachineName" : _machineName,
             @"MachineType" : _machineType
             };
}

@end

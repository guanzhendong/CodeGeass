//
//  ZDLoginApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDLoginApi.h"

@implementation ZDLoginApi
{
    NSString *_account;
    NSString *_key;
    NSString *_token;
    NSInteger _loginType;
    NSInteger _lsPush;
    NSInteger _pushType;
    NSInteger _timeFlag;
    NSInteger _type;
    NSInteger _version;
}

- (instancetype)initWithAccount:(NSString *)account
                            key:(NSString *)key
                          token:(NSString *)token
                      loginType:(NSInteger)loginType
                         lsPush:(NSInteger)lsPush
                       pushType:(NSInteger)pushType
                       timeFlag:(NSInteger)timeFlag
                           type:(NSInteger)type
                        version:(NSInteger)version
{
    self = [super init];
    if (self) {
        _account    = account;
        _key        = key;
        _token      = token;
        _loginType  = loginType;
        _lsPush     = lsPush;
        _pushType   = pushType;
        _timeFlag   = timeFlag;
        _type       = type;
        _version    = version;
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

- (NSString *)requestUrl {
    return HTTP_API_LOGIN;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"account"    : _account,
             @"key"        : _key,
             @"token"      : _token,
             @"login_type" : @(_loginType),
             @"ls_push"    : @(_lsPush),
             @"push_type"  : @(_pushType),
             @"timeflag"   : [NSString stringWithFormat:@"%ld",_timeFlag],
             @"type"       : [NSString stringWithFormat:@"%ld",_type],
             @"version"    : [NSString stringWithFormat:@"%ld",_version]
             };
}

@end

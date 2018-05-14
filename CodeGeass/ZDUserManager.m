//
//  ZDUserManager.m
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDUserManager.h"
#import "ZDLoginApi.h"
#import "ZDUserInfoApi.h"
#import "ZDUserAuthApi.h"
#import "ZDCorpManager.h"
#import "ZDSessionManager.h"
#import "ZDGroupManager.h"
#import "ZDCrmManager.h"

@implementation ZDUserManager

SINGLETON_IMPLEMENTATION(Manager)


- (YTKRequest *)loginWithAccount:(NSString *)account
                        password:(NSString *)password
                         success:(HttpRequestSuccessBlock)success
                         failure:(HttpRequestFailureBlock)failure
{
    // 当前时间戳，转为整型
    NSInteger timestamp = [NSDate date].timeIntervalSince1970;
    NSString *key = [NSString stringWithFormat:@"%@%@%ld",account,password.md5String,timestamp];
    ZDLoginApi *api = [[ZDLoginApi alloc] initWithAccount:account
                                                      key:key.md5String
                                                    token:@""
                                                loginType:1
                                                   lsPush:1
                                                 pushType:0
                                                 timeFlag:timestamp
                                                     type:6
                                                  version:7100];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            self.userModel = [ZDUserModel modelWithDictionary:model.data];
            
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"currentAccount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self userInfoWithSuccess:nil failure:nil];
            [self userAuthWithSuccess:nil failure:nil];
            
            // 获取基础数据
            [[ZDCrmManager sharedManager] requestAllCrms];
            [[ZDCorpManager sharedManager] requestAllCorps];
            [[ZDGroupManager sharedManager] requestAllGroups];
            [[ZDSessionManager sharedManager] requestAllSessions];
            
        }else {
            [SVProgressHUD showErrorWithStatus:model.msg];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    model.time);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}

- (YTKRequest *)userInfoWithSuccess:(HttpRequestSuccessBlock)success
                            failure:(HttpRequestFailureBlock)failure
{
    ZDUserInfoApi *api = [[ZDUserInfoApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            [self.userModel updateWithDictionary:model.data];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    model.time);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}

- (YTKRequest *)userAuthWithSuccess:(HttpRequestSuccessBlock)success
                            failure:(HttpRequestFailureBlock)failure
{
    ZDUserAuthApi *api = [[ZDUserAuthApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            [self.userModel.authModel modelSetWithDictionary:model.data];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    model.time);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}


@end

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
#import "ZDGetSMSVerificationCodeApi.h"
#import "ZDVerifySMSCodeApi.h"

@implementation ZDUserManager

SINGLETON_IMPLEMENTATION(Manager)


- (YTKRequest *)loginWithAccount:(NSString *)account
                        password:(NSString *)password
                         success:(HttpRequestSuccessBlock)success
                         failure:(HttpRequestFailureBlock)failure
{
    ZDLoginApi *api = [[ZDLoginApi alloc] initWithAccount:account password:password];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseObject];
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
            
        } else if (model.ret == 1010) {//为帐号安全，在新设备登录EC时需短信验证
            
        } else {
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

- (YTKRequest *)requestSMSCodeWithAccount:(NSString *)account
                                  success:(HttpRequestSuccessBlock)success
                                  failure:(HttpRequestFailureBlock)failure
{
    ZDGetSMSVerificationCodeApi *api = [[ZDGetSMSVerificationCodeApi alloc] initWithAccount:account type:1010];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseObject];
        if (model.ret == 200) {
            
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

- (YTKRequest *)requestVerifySMSCodeWithAccount:(NSString *)account
                               verificationCode:(NSString *)verificationCode
                                        success:(HttpRequestSuccessBlock)success
                                        failure:(HttpRequestFailureBlock)failure
{
    ZDVerifySMSCodeApi *api = [[ZDVerifySMSCodeApi alloc] initWithAccount:account type:1010 verifyid:verificationCode];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dic = request.responseObject;
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseObject];
        if (model.ret == 200) {
            self.userModel = [ZDUserModel modelWithDictionary:dic];
            
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"currentAccount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [YYKeychain setPassword:[dic sa_stringForKey:@"SecreKey"] forService:[[UIApplication sharedApplication].appBundleName stringByAppendingString:@"_SecreKey"] account:account];
            
            [self userInfoWithSuccess:nil failure:nil];
            [self userAuthWithSuccess:nil failure:nil];
            
            // 获取基础数据
            [[ZDCrmManager sharedManager] requestAllCrms];
            [[ZDCorpManager sharedManager] requestAllCorps];
            [[ZDGroupManager sharedManager] requestAllGroups];
            [[ZDSessionManager sharedManager] requestAllSessions];
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

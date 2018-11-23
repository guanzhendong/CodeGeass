//
//  ZDUserManager.h
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/*
 * 用户数据管理类
 */

#import <Foundation/Foundation.h>
#import "ZDUserModel.h"

#define ZD_USERMODEL ([ZDUserManager sharedManager].userModel)
#define ZD_USERID    ([ZDUserManager sharedManager].userModel.Id)

@interface ZDUserManager : NSObject

SINGLETON_INTERFACE(Manager)

@property (nonatomic, strong) ZDUserModel *userModel;


- (YTKRequest *)loginWithAccount:(NSString *)account
                        password:(NSString *)password
                         success:(HttpRequestSuccessBlock)success
                         failure:(HttpRequestFailureBlock)failure;

- (YTKRequest *)userInfoWithSuccess:(HttpRequestSuccessBlock)success
                            failure:(HttpRequestFailureBlock)failure;

- (YTKRequest *)userAuthWithSuccess:(HttpRequestSuccessBlock)success
                            failure:(HttpRequestFailureBlock)failure;

- (YTKRequest *)requestSMSCodeWithAccount:(NSString *)account
                                  success:(HttpRequestSuccessBlock)success
                                  failure:(HttpRequestFailureBlock)failure;

- (YTKRequest *)requestVerifySMSCodeWithAccount:(NSString *)account
                               verificationCode:(NSString *)verificationCode
                                        success:(HttpRequestSuccessBlock)success
                                        failure:(HttpRequestFailureBlock)failure;

@end

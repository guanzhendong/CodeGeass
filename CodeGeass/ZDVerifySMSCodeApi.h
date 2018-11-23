//
//  ZDVerifySMSCodeApi.h
//  CodeGeass
//
//  Created by ec on 2018/11/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDVerifySMSCodeApi : YTKRequest

/**
 帐号安全-验证短信接口
 
 @param account 验证账户
 @param type 获取短信严重码的原因（Login返回错误码）
 @param verifyid 验证码
 @return api
 */
- (instancetype)initWithAccount:(NSString *)account
                           type:(NSInteger )type
                       verifyid:(NSString *)verifyid;

@end

NS_ASSUME_NONNULL_END

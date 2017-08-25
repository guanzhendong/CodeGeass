//
//  ZDNetworking.h
//  CodeGeass
//
//  Created by ec on 2017/4/25.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

// 基于AFNetworking的封装，集约型网络请求

#import <Foundation/Foundation.h>

@interface ZDNetworking : NSObject

+ (void)GET:(NSString *)urlString
  parameter:(id)parameter
    success:(void (^)(id data))success
    failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)urlString
   parameter:(id)parameter
     success:(void (^)(id data))success
     failure:(void (^)(NSError *error))failure;

@end

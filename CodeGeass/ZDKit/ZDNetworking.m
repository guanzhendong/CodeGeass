//
//  ZDNetworking.m
//  CodeGeass
//
//  Created by ec on 2017/4/25.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDNetworking.h"
#import <AFHTTPSessionManager.h>
#import <AFNetworkActivityIndicatorManager.h>

@implementation ZDNetworking

+ (AFHTTPSessionManager *)sharedAFManager
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:HTTP_HOST]];
        
        /* 设置请求服务器数类型式为 json
         根据服务器的设定不同还可以设置：
         json：[AFJSONRequestSerializer serializer](常用)
         http：[AFHTTPRequestSerializer serializer]
         */
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存，注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad
//        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        // 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用
//        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        
        // 打开状态栏的等待菊花
//        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        
        /* 设置返回数据类型为 json, 分别设置请求以及相应的序列化器
         根据服务器的设定不同还可以设置：
         json：[AFJSONResponseSerializer serializer](常用)
         http：[AFHTTPResponseSerializer serializer]
         */
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置响应数据的基本类型，服务端返回数据的类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"image/*", nil];
        
        /* https 参数配置
         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
         */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.allowInvalidCertificates = YES;
//        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
        
        /*! 自定义的CA证书配置如下： */
        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
        /*!
         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
         */
        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //        policy.allowInvalidCertificates = YES;
        //        manager.securityPolicy = policy;
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //        policy.allowInvalidCertificates = YES;
        //        manager.securityPolicy = policy;
    });
    return manager;
}

+ (void)GET:(NSString *)urlString
  parameter:(id)parameter
    success:(void (^)(id data))success
    failure:(void (^)(NSError *error))failure
{
    [[self sharedAFManager] GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)urlString
   parameter:(id)parameter
     success:(void (^)(id data))success
     failure:(void (^)(NSError *error))failure
{
    [[self sharedAFManager] POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

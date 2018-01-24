//
//  ZDConsts.h
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>




#pragma mark - Notification













#pragma mark - API

extern NSString * const HTTP_HOST;

extern NSString * const IM_HOST;

extern NSString * const HTTP_API_LOGIN;
















#pragma mark - Timestamp

#define kZDTimestampCrm [NSString stringWithFormat:@"kZDTimestampCrm_%@",ZD_USERID]
#define kZDTimestampCrmShare [NSString stringWithFormat:@"kZDTimestampCrmShare_%@",ZD_USERID]
#define kZDTimestampCorp [NSString stringWithFormat:@"kZDTimestampCorp_%@",ZD_USERID]
#define kZDTimestampSession [NSString stringWithFormat:@"kZDTimestampSession_%@",ZD_USERID]




#pragma mark - http cache time

extern NSInteger const kZDHttpCacheTimeOneMinute;
extern NSInteger const kZDHttpCacheTimeOneHour;
extern NSInteger const kZDHttpCacheTimeOneDay;



#pragma mark - Common Date Fromatter String
extern NSString * const kZDCommonDateFromatter;





#pragma mark - Common block

typedef void(^HttpRequestSuccessBlock)(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp);
typedef void(^HttpRequestFailureBlock)(NSInteger errorCode, NSString *errorMsg);

@interface ZDConsts : NSObject

@end

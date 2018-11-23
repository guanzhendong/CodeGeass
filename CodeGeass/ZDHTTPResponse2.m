//
//  ZDHTTPResponse2.m
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDHTTPResponse2.h"

@implementation ZDHTTPResponse2

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ret"  : @"ErrorCode",
             @"msg"  : @"ErrorInfo",
             @"time" : @"TimeStamp",
             @"data" : @"MsgBody"
             };
}

@end

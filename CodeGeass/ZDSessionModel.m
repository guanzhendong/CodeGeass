//
//  ZDSessionModel.m
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDSessionModel.h"

@implementation ZDSessionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"msgId"   : @"MsgId",
             @"talkId"  : @"TalkID",
             @"time"    : @"Time",
             @"number"  : @"Num",
             @"content" : @"Content",
             @"type"    : @"Type",
             @"Id"      : @"ID",
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSArray *)getPrimaryKeyUnionArray {
    return @[@"Id",@"type"];
}

@end

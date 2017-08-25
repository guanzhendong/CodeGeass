//
//  ZDQQFriend.m
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDQQFriend.h"

@implementation ZDQQFriend

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"        : @"f_frd_qq_id",
             @"name"      : @"f_nickname",
             @"remark"    : @"f_remark",
             @"face"      : @"f_face",
             @"groupId"   : @"f_group_id",
             @"crmId"     : @"f_crm_id",
             @"crmUserId" : @"f_crm_userid",
             @"time"      : @"f_ctime"
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSString *)getPrimaryKey {
    return @"Id";
}

@end

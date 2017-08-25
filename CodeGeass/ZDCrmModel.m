//
//  ZDCrmModel.m
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCrmModel.h"

@implementation ZDCrmModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"           : @"f_crm_id",
             @"name"         : @"f_name",
             @"face"         : @"f_face",
             @"mobile"       : @"f_mobile",
             @"phone"        : @"f_phone",
             @"tagIds"       : @"f_tagIds",
             @"company"      : @"f_company",
             @"userId"       : @"f_user_id",
             @"qqId"         : @"f_qq_id",
             @"qq"           : @"f_qq",
             @"friendId"     : @"f_friend_id",
             @"step"         : @"f_step",
             @"call"         : @"f_call",
             @"position"     : @"f_title",
             @"del"          : @"f_del",
             @"classId"      : @"f_classID",
             @"email"        : @"f_email",
             @"gender"       : @"f_gender",
             @"csGuid"       : @"f_cs_guid",
             @"createType"   : @"f_type",
             @"createTime"   : @"f_create_time",
             @"modifyTime"   : @"f_modify_time",
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSString *)getPrimaryKey {
    return @"Id";
}

@end

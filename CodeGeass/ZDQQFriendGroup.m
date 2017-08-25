//
//  ZDQQFriendGroup.m
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDQQFriendGroup.h"

@implementation ZDQQFriendGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"   : @"f_group_id",
             @"name" : @"f_group_name"
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSString *)getPrimaryKey {
    return @"Id";
}

@end

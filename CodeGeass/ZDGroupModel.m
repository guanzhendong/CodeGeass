//
//  ZDGroupModel.m
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDGroupModel.h"

@implementation ZDGroupModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"           : @[@"GroupID",@"discussId"],
             @"name"         : @[@"GroupName",@"theme"],
             @"creatorId"    : @"CreatorID",
             @"creatorName"  : @"Name",
             @"number"       : @[@"Nums",@"nums"],
             @"push"         : @[@"Push",@"lspush"],
             @"announcement" : @"AD",
             @"memberNames"  : @[@"MemberNames",@"members"],
             @"time"         : @[@"Time",@"lastModiTime"]
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSArray *)getPrimaryKeyUnionArray {
    return @[@"Id",@"type"];
}

@end

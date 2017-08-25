//
//  ZDContactModel.m
//  CodeGeass
//
//  Created by ec on 2017/4/20.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDContactModel.h"

@implementation ZDContactModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"      : @[@"Id"],
             @"name"    : @[@"Name"],
             @"face"    : @[@"Url"],
             @"mobile"  : @[@"Account"]
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSString *)getPrimaryKey {
    return @"Id";
}

@end

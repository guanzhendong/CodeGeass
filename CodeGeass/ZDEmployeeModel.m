//
//  ZDEmployeeModel.m
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDEmployeeModel.h"

@implementation ZDEmployeeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"face"       : @"f_face",
             @"Id"         : @"id",
             @"parentId"   : @"f_parent_id",
             @"hidden"     : @"f_noshow",
             @"updateTime" : @"f_ctime",
             @"position"   : @"title",
             };
}

+ (NSString *)getTableName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), ZD_USERID];
}

+ (NSString *)getPrimaryKey {
    return @"Id";
}



// NSObject+YYModel里面的方法，很不错，直接完成了NSCoding和NSCopying协议需要重写的方法
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { return [self modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }

@end

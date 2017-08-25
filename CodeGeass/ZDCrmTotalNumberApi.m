//
//  ZDCrmTotalNumberApi.m
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCrmTotalNumberApi.h"

@implementation ZDCrmTotalNumberApi {
    NSInteger _type;
}

- (instancetype)initWithType:(NSInteger)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/crm/gettotal";
}

- (id)requestArgument {
    return @{
             @"share" : @(_type)
             };
}

@end

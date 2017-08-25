//
//  ZDCrmListApi.m
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCrmListApi.h"

@implementation ZDCrmListApi{
    NSInteger _type;
    NSInteger _startIndex;
    NSTimeInterval _time;
}

- (instancetype)initWithType:(NSInteger)type
                  startIndex:(NSInteger)startIndex
                        time:(NSTimeInterval)time
{
    self = [super init];
    if (self) {
        _type = type;
        _startIndex = startIndex;
        _time = time;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/newcrm/listcrm";
}

- (id)requestArgument {
    return @{
             @"share" : @(_type),
             @"start" : @(_startIndex),
             @"time"  : @(_time)
              };
}

@end

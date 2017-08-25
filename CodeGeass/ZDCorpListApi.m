//
//  ZDCorpListApi.m
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCorpListApi.h"

@implementation ZDCorpListApi {
    NSInteger _startIndex;
    NSInteger _timestamp;
}

- (instancetype)initWithStartIndex:(NSInteger)startIndex
                         timestamp:(NSInteger)timestamp;
{
    self = [super init];
    if (self) {
        _startIndex = startIndex;
        _timestamp = timestamp;
    }
    return self;
}

- (NSString*)requestUrl {
    return @"api/corp/stru";
}

- (id)requestArgument {
    return @{
             @"start" : @(_startIndex),
             @"per"   : @1000,
             @"time"  : @(_timestamp)
             };
}

@end

//
//  ZDCalculator2.m
//  CodeGeass
//
//  Created by ec on 2017/5/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCalculator2.h"

@implementation ZDCalculator2

- (ZDCalculator2 *)calculate:(float (^)(float result))block {
    _result = block(0);
    return self;
}

- (ZDCalculator2 *)equal:(BOOL (^)(float result))block {
    _isEqule = block(_result);
    return self;
}

@end

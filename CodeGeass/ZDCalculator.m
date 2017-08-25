//
//  ZDCalculator.m
//  CodeGeass
//
//  Created by ec on 2017/5/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCalculator.h"

@implementation ZDCalculatorMaker : NSObject

- (ZDCalculatorMaker *(^)(float))add {
    return ^ZDCalculatorMaker *(float value) {
        _result += value;
        return self;
    };
}
- (ZDCalculatorMaker *(^)(float))sub {
    return ^ZDCalculatorMaker *(float value) {
        _result -= value;
        return self;
    };
}
- (ZDCalculatorMaker *(^)(float))multi {
    return ^ZDCalculatorMaker *(float value) {
        _result *= value;
        return self;
    };
}
- (ZDCalculatorMaker *(^)(float))divide {
    return ^ZDCalculatorMaker *(float value) {
        _result /= value;
        return self;
    };
}

@end

@implementation ZDCalculator

+ (float)calculate:(void (^)(ZDCalculatorMaker *))block {
    ZDCalculatorMaker *maker = [ZDCalculatorMaker new];
    block(maker);
    return maker.result;
}

@end

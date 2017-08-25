//
//  ZDCalculator2.h
//  CodeGeass
//
//  Created by ec on 2017/5/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/**
 函数式编程思想：是把操作尽量写成一系列嵌套的函数或者方法调用。
 
 函数式编程特点：每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
 
 代表：ReactiveCocoa。用函数式编程实现，写一个加法计算器,并且加法计算器自带判断是否等于某个值.
 
 ZDCalculator2 *zzz = [ZDCalculator2 new];
 [[zzz calculate:^float(float result) {
    result = 2;
    return result;
 }] equal:^BOOL(float result) {
    return result == 2;
 }];
 NSLog(@"%d",zzz.isEqule);
 */

#import <Foundation/Foundation.h>

@interface ZDCalculator2 : NSObject

@property (nonatomic) float result;
@property (nonatomic) BOOL isEqule;

- (ZDCalculator2 *)calculate:(float (^)(float result))block;

- (ZDCalculator2 *)equal:(BOOL (^)(float result))block;

@end

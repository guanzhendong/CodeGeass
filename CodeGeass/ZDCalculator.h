//
//  ZDCalculator.h
//  CodeGeass
//
//  Created by ec on 2017/5/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//


/**
 链式编程思想：是将多个操作（多行代码）通过点号(.)链接在一起成为一句代码,使代码可读性好。a(1).b(2).c(3)
 
 链式编程特点：方法的返回值是block,block必须有返回值（本身对象），block有参数（需要操作的值），调用是 add(参数)
 
 代表：masonry框架。模仿masonry，写一个计算器
 
 float www = [ZDCalculator calculate:^(ZDCalculatorMaker *maker) {
    maker.add(10).sub(4).multi(8).divide(3);
 }];
 */


#import <Foundation/Foundation.h>

@interface ZDCalculatorMaker : NSObject

@property (nonatomic) float result;

- (ZDCalculatorMaker *(^)(float))add;
- (ZDCalculatorMaker *(^)(float))sub;
- (ZDCalculatorMaker *(^)(float))multi;
- (ZDCalculatorMaker *(^)(float))divide;

@end

@interface ZDCalculator : NSObject

+ (float)calculate:(void (^)(ZDCalculatorMaker *maker))block;

@end

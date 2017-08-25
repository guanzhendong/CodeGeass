//
//  ZDTestViewController.h
//  CodeGeass
//
//  Created by ec on 2017/1/4.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDBaseViewController.h"

// typedef block
typedef void(^block1)();
typedef BOOL(^block2)(BOOL);

@interface ZDTestViewController : ZDBaseViewController

// block属性
@property (nonatomic, copy) void(^blockName1)();
@property (nonatomic, copy) BOOL(^blockName2)(BOOL);

// block作为方法形参
- (void)method1:(void(^)())blockName;
- (void)method2:(BOOL(^)(BOOL))blockName;

// block作为方法返回值
- (void(^)())back1;
- (BOOL(^)(BOOL))back2;

@end

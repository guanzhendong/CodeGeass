//
//  ZDMouseDrinkTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/7/17.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDMouseDrinkTest : XCTestCase

@end

@implementation ZDMouseDrinkTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    // 面试算法题：
    //  有16个瓶子，其中最多有一瓶有毒，现在有四只老鼠，喝了有毒的水之后，第二天就会死。如何在第二天就可以判断出哪个瓶子有毒
    //  答：开始我想到的是常规思路二分法，717，和面试官说了，发现四只老鼠根本不够，面试官友好的提示从老鼠面去想，这时候很快想到了一个老鼠有死和不死，也就0和1两个状态，四只老鼠有16个组合，正好是足够的。但是怎么分配瓶子，还没想好，演算了一会儿，因为面试官这边时间有限，就说思路是正确的。下面有兴趣在看怎么分哈。面试就到此结束了。
    
    NSMutableIndexSet *mouseA = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *mouseB = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *mouseC = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *mouseD = [NSMutableIndexSet indexSet];
    for (int i = 0; i < 16; i++) {
        if (i & (1 << 0)) {
            [mouseA addIndex:i];
        }
        if (i & (1 << 1)) {
            [mouseB addIndex:i];
        }
        if (i & (1 << 2)) {
            [mouseC addIndex:i];
        }
        if (i & (1 << 3)) {
            [mouseD addIndex:i];
        }
    }
    NSLog(@"\n老鼠A喝第%@瓶水\n老鼠B喝第%@瓶水\n老鼠C喝第%@瓶水\n老鼠D喝第%@瓶水", mouseA, mouseB, mouseC, mouseD);
    
    /*
     老鼠A喝第<NSMutableIndexSet: 0x7fe9797226c0>[number of indexes: 8 (in 8 ranges), indexes: (1 3 5 7 9 11 13 15)]瓶水
     老鼠B喝第<NSMutableIndexSet: 0x7fe979722a80>[number of indexes: 8 (in 4 ranges), indexes: (2-3 6-7 10-11 14-15)]瓶水
     老鼠C喝第<NSMutableIndexSet: 0x7fe979722ab0>[number of indexes: 8 (in 2 ranges), indexes: (4-7 12-15)]瓶水
     老鼠D喝第<NSMutableIndexSet: 0x7fe979722ae0>[number of indexes: 8 (in 1 ranges), indexes: (8-15)]瓶水
     */
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  ZDAtomicTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/6/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDAtomicTest : XCTestCase

@property (atomic, assign) NSInteger count;

@end

@implementation ZDAtomicTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    _count = 0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 1000; i++) {
            _count++;
            NSLog(@"count: %ld", _count);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 1000; i++) {
            _count++;
            NSLog(@"count: %ld", _count);
        }
    });
    
    // 显然，atomic不能保证此情形下的线程安全
    
    
    // atomic的本意是指属性的存取方法是线程安全的（thread safe），并不保证整个对象是线程安全的。比如，声明一个NSMutableArray的原子属性mutarr，此时self. mutarr和self. mutarr= othermutarr都是线程安全的。但是，使用[self. mutarrobjectAtIndex:index]就不是线程安全的，需要用锁来保证线程安全性。
    // 同时还要说明一下使用atomic的性能问题, atomic要比nonatomic慢很多.

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

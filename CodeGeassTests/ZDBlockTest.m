//
//  ZDBlockTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/6/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDBlockTest : XCTestCase

@end

@implementation ZDBlockTest

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
    
    
    NSString *str = @"0";
    NSLog(@"指针地址：%p  对象地址%p", &str, str);
    void (^block)(void) = ^{
        NSLog(@"指针地址：%p  对象地址%p", &str, str);
    };
    block();
    NSLog(@"指针地址：%p  对象地址%p\n", &str, str);
    
//    指针地址：0x7fff5f16ccd8  对象地址0x11add9370
//    指针地址：0x7fa542d55030  对象地址0x11add9370
//    指针地址：0x7fff5f16ccd8  对象地址0x11add9370
    
    
    __block NSString *str1 = @"1";
    NSLog(@"指针地址：%p  对象地址%p", &str1, str1);
    void (^block1)(void) = ^{
        NSLog(@"指针地址：%p  对象地址%p", &str1, str1);
    };
    block1();
    NSLog(@"指针地址：%p  对象地址%p", &str1, str1);
    
//    指针地址：0x7fff544a8ca0  对象地址0x1238cb3d0
//    指针地址：0x7fb59e53aa18  对象地址0x1238cb3d0
//    指针地址：0x7fb59e53aa18  对象地址0x1238cb3d0
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

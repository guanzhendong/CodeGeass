//
//  ZDNotificationTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/6/1.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDNotificationTest : XCTestCase

@end

@implementation ZDNotificationTest

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
    
    // 主线程注册，子线程post，通知能收到，selector在子线程
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationTest) name:@"notificationTest" object:nil];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationTest" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationTest2) name:@"notificationTest2" object:nil];
     
        dispatch_async(dispatch_get_main_queue(), ^{
            // 子线程注册，主线程post，通知能收到，selector在主线程
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationTest2" object:nil];
        });
       
    });
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)handleNotificationTest {
    NSLog(@"handleNotificationTest: %@",[NSThread currentThread]);
}

- (void)handleNotificationTest2 {
    NSLog(@"handleNotificationTest2: %@",[NSThread currentThread]);
}

@end

//
//  ZDEXCTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/9/7.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDEXCTest : XCTestCase

@end

@implementation ZDEXCTest

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
    
    
    UIView *v1 = [UIView new];
    UIView *v2 = v1;
//    [v2 retain];
    [v1 release];
    v2.backgroundColor = [UIColor redColor];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

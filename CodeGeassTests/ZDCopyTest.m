//
//  ZDCopyTest.m
//  CodeGeassTests
//
//  Created by ec on 2019/2/18.
//  Copyright © 2019年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZDCopyTest : XCTestCase

@end

@implementation ZDCopyTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
    NSString *a = @"1";
    NSArray *arr = @[a];
    NSArray *copyArr = arr.mutableCopy;
    NSLog(@"%p---%p", arr, copyArr);
    NSLog(@"%p---%p", arr[0], copyArr[0]);
    
    /*
     2019-02-18 09:50:53.565603+0800 xctest[6505:90109] 0x7ff0e3dd5af0---0x7ff0e3dd5dd0
     2019-02-18 09:50:53.565869+0800 xctest[6505:90109] 0x1189ed408---0x1189ed408
     
     mutableCopy后，数组是一个新的数组，但是里面的数据还是原来的
     */
    
    [self singleNumber:@[@4,@1,@2,@1,@2,@1]];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (int)singleNumber:(NSArray <NSNumber *>*)nums {
    int result = 0 ;
    
    for (int i=0; i<nums.count; i++)  {
        result = result ^ nums[i].intValue;
    }
    return result;
}

@end

//
//  ZDExchangeMethodTest.m
//  CodeGeassTests
//
//  Created by ec on 2018/9/13.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@interface ZDExchangeMethodTest : XCTestCase

@end

@implementation ZDExchangeMethodTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    [ZDExchangeMethodTest exchangeInstanceMethod:[ZDExchangeMethodTest class] method1Sel:@selector(method1) method2Sel:@selector(method2)];
    [ZDExchangeMethodTest exchangeInstanceMethod:[ZDExchangeMethodTest class] method1Sel:@selector(method1) method2Sel:@selector(method3)];
    [self performSelector:@selector(method1)];
//    [self method2];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//- (void)method1 {
//    NSLog(@"1");
//}

- (void)method2 {
    NSLog(@"2");
}

- (void)method3 {
    NSLog(@"3");
}

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end

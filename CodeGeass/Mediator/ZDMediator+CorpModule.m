//
//  ZDMediator+CorpModule.m
//  CodeGeass
//
//  Created by ec on 2018/9/3.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "ZDMediator+CorpModule.h"

@implementation ZDMediator (CorpModule)

- (UIViewController *)corpInfoViewControllerWithParams:(NSDictionary *)params {
    UIViewController *viewController = [self performTarget:@"CorpModule" action:@"corpInfoViewControllerWithParams" params:params];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
        return [[UIViewController alloc] init];
    }
}

- (id)employeeWithId:(NSString *)Id {
    return [self performTarget:@"CorpModule" action:@"employeeWithParams" params:@{@"Id":Id}];
}

@end

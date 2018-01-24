//
//  UIResponder+ZDRouter.m
//  CodeGeass
//
//  Created by ec on 2017/10/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIResponder+ZDRouter.h"

@implementation UIResponder (ZDRouter)

- (void)zd_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] zd_routerEventWithName:eventName userInfo:userInfo];
}

@end

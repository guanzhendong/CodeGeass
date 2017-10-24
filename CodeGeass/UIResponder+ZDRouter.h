//
//  UIResponder+ZDRouter.h
//  CodeGeass
//
//  Created by ec on 2017/10/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (ZDRouter)

- (void)zd_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

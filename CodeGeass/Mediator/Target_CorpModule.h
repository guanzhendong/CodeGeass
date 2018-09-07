//
//  Target_CorpModule.h
//  CodeGeass
//
//  Created by ec on 2018/9/3.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDEmployeeModel;

@interface Target_CorpModule : NSObject

- (UIViewController *)Action_corpInfoViewControllerWithParams:(NSDictionary *)params;

- (ZDEmployeeModel *)Action_employeeWithParams:(NSDictionary *)params;

@end

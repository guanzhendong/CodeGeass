//
//  Target_CorpModule.m
//  CodeGeass
//
//  Created by ec on 2018/9/3.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "Target_CorpModule.h"
#import "ZDCorpInfoViewController.h"
#import "ZDCorpManager.h"

@implementation Target_CorpModule

- (UIViewController *)Action_corpInfoViewControllerWithParams:(NSDictionary *)params {
    ZDCorpInfoViewController *vc = [[ZDCorpInfoViewController alloc] initWithEmployeeId:params[@"employeeId"]];
    return vc;
}

- (ZDEmployeeModel *)Action_employeeWithParams:(NSDictionary *)params {
    return [[ZDCorpManager sharedManager] employeeWithId:params[@"Id"]];
}

@end

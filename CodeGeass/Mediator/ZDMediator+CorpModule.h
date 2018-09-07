//
//  ZDMediator+CorpModule.h
//  CodeGeass
//
//  Created by ec on 2018/9/3.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "ZDMediator.h"

@interface ZDMediator (CorpModule)

- (UIViewController *)corpInfoViewControllerWithParams:(NSDictionary *)params;

- (id)employeeWithId:(NSString *)Id;

@end

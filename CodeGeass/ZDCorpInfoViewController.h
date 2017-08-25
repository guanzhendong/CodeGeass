//
//  ZDCorpInfoViewController.h
//  CodeGeass
//
//  Created by ec on 2017/5/8.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDTranslucentViewController.h"

@interface ZDCorpInfoViewController : ZDTranslucentViewController

@property (nonatomic, assign) BOOL showNavigationBarWhenFromSearch;

- (instancetype)initWithEmployeeId:(NSString *)employeeId;

@end

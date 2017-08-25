//
//  ZDTranslucentViewController.m
//  CodeGeass
//
//  Created by ec on 2017/5/9.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDTranslucentViewController.h"

@interface ZDTranslucentViewController ()

@end

@implementation ZDTranslucentViewController

- (instancetype)init {// 不知道为啥在这里面设置_navigationBar会使工具页数据不出来，
    self = [super init];
    if (self) {
//        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAVIGATION_HEIGHT)];
//        [_navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [_navigationBar setShadowImage:[UIImage new]];
//        _navigationBar.backgroundColor = [UIColor zd_navBgColor];
//        if ([self isTranslucentNavBar]) {
//            _navigationBar.alpha = 0;
//        }
//        [self.view addSubview:_navigationBar];
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:_translucentNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _translucentNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAVIGATION_HEIGHT)];
    [_translucentNavigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [_translucentNavigationBar setShadowImage:[UIImage new]];
    _translucentNavigationBar.backgroundColor = [UIColor zd_navBgColor];
    if ([self isTranslucentNavBar]) {
        _translucentNavigationBar.alpha = 0;
    }
    [self.view addSubview:_translucentNavigationBar];
}

- (BOOL)isTranslucentNavBar {
    return NO;
}

@end

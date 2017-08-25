//
//  ZDTranslucentNavigationController.m
//  CodeGeass
//
//  Created by ec on 2017/5/9.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDTranslucentNavigationController.h"

@interface ZDTranslucentNavigationController ()

@end

@implementation ZDTranslucentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

@end

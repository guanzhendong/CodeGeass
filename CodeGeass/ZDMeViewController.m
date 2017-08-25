//
//  ZDMeViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDMeViewController.h"
#import "ZDLoginViewController.h"

@interface ZDMeViewController ()

@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createRightButtonWithTitle:@"退出登录" action:@selector(logout)];
}

- (void)logout {
    [YYKeychain deletePasswordForService:[UIApplication sharedApplication].appBundleName
                                 account:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAccount"]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentAccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [ZDAppDelegate changeRootViewController:[ZDLoginViewController new]];
}

@end

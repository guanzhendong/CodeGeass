//
//  ZDMeViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDMeViewController.h"
#import "ZDLoginViewController.h"
#import "DKNightVersion.h"

@interface ZDMeViewController ()

@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createRightButtonWithTitle:@"退出登录" action:@selector(logout)];
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)];
    sw.on = [self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight];
    [self.view addSubview:sw];
    [sw addTarget:self action:@selector(night:) forControlEvents:UIControlEventValueChanged];
}

- (void)logout {
    [YYKeychain deletePasswordForService:[UIApplication sharedApplication].appBundleName
                                 account:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAccount"]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentAccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [ZDAppDelegate changeRootViewController:[ZDLoginViewController new]];
}

- (void)night:(UISwitch *)sw {
    if (sw.isOn) {// 夜间模式
        [self.dk_manager nightFalling];
    } else {
        [self.dk_manager dawnComing];
    }
}

@end

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
#import "FCAlertView.h"

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
    
    UIButton *btn = [UICreator createButtonWithFrame:CGRectMake(100, 200, 100, 40) title:@"FCAlertView" action:^{
        FCAlertView *alert = [FCAlertView new];
        alert.bounceAnimations = YES;
        alert.titleFont = [UIFont boldSystemFontOfSize:18];
//        [alert makeAlertTypeSuccess];
        alert.colorScheme = [UIColor randomFlatColor];
        alert.avoidCustomImageTint = YES;
        alert.fullCircleCustomImage = YES;
        UIImage *img = [UIImage imageNamed:@"nazha"];
        [alert showAlertWithTitle:@"古力娜扎" withSubtitle:@"古力娜扎（Gulnazar），1992年5月2日出生于新疆乌鲁木齐市，中国内地影视女演员、平面模特。2011年，古力娜扎考入北京电影学院表演系本科班就读；同年，她签约上海唐人电影制作有限公司，并出演个人首部电视剧《轩辕剑之天之痕》，而她也因此被观众熟知。此后两年，古力娜扎转战大银幕，并出演了警匪片《警察故事2013》、悬疑片《全城通缉》等电影作品。2015年，古力娜扎不仅主演了爱情片《爱我就陪我看电影》、神话剧《山海经之赤影传说》等影视作品" withCustomImage:[img imageByRoundCornerRadius:img.size.width/2] withDoneButtonTitle:@"好的" andButtons:@[@"取消"]];
    }];
    [self.view addSubview:btn];
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

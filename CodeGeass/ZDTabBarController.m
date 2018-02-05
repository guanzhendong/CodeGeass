//
//  ZDTabBarController.m
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ZDTabBarController.h"
#import "ZDBaseNavigationController.h"
#import "ZDSessionListViewController.h"
#import "ZDCrmViewController.h"
#import "ZDToolViewController.h"
#import "ZDMeViewController.h"
#import "ZDTranslucentViewController.h"
#import "ZDTranslucentNavigationController.h"
#import "ZDTestViewController.h"
#import "ZDContactViewController.h"

@interface ZDTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupItems];
//    [self setTabBarItemBadgeValue:@"2" itemIndex:0];
//    [self setTabBarItemBadgeValue:@"10" itemIndex:1];
//    [self setTabBarItemBadgeValue:@"99" itemIndex:2];
//    [self setTabBarItemBadgeValue:@"99+" itemIndex:3];
    
    // 设为NO可以关闭毛玻璃效果
//    self.tabBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle3DTouch:) name:@"3DTouch" object:nil];
}

- (void)setupItems {
    UINavigationController *sessionNav = [self itemWithViewController:[ZDSessionListViewController new]
                                                                title:@"消息"
                                                          normalImage:[UIImage imageNamed:@"tabBar_session_normal"]
                                                        selectedImage:[UIImage imageNamed:@"tabBar_session_selected"]];
    UINavigationController *crmNav = [self itemWithViewController:[ZDCrmViewController new]
                                                            title:@"客户"
                                                      normalImage:[UIImage imageNamed:@"tabBar_crm_normal"]
                                                    selectedImage:[UIImage imageNamed:@"tabBar_crm_selected"]];
    UINavigationController *toolNav = [self itemWithViewController:[ZDToolViewController new]
                                                             title:@"工具"
                                                       normalImage:[UIImage imageNamed:@"tabBar_tool_normal"]
                                                     selectedImage:[UIImage imageNamed:@"tabBar_tool_selected"]];
    UINavigationController *meNav = [self itemWithViewController:[ZDMeViewController new]
                                                           title:@"我"
                                                     normalImage:[UIImage imageNamed:@"tabBar_me_normal"]
                                                   selectedImage:[UIImage imageNamed:@"tabBar_me_selected"]];
    
    self.viewControllers = @[sessionNav,crmNav,toolNav,meNav];
}

- (UINavigationController *)itemWithViewController:(UIViewController *)viewController
                                             title:(NSString *)title
                                       normalImage:(UIImage *)normalImage
                                     selectedImage:(UIImage *)selectedImage
{
    UINavigationController *nav;
    if ([viewController isKindOfClass:[ZDTranslucentViewController class]]) {
        nav = [[ZDTranslucentNavigationController alloc] initWithRootViewController:viewController];
    } else {
        nav = [[ZDBaseNavigationController alloc] initWithRootViewController:viewController];
    }
    viewController.title = title;
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                   image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                           selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor zd_greenThemeColor]} forState:UIControlStateSelected];
    return nav;
}


- (void)setTabBarItemBadgeValue:(NSString *)badgeValue
                      itemIndex:(NSUInteger)itemIndex
{
    if ([badgeValue isKindOfClass:[NSNull class]]) {
        return;
    }
    if (itemIndex + 1 > self.viewControllers.count) {
        return;
    }
    ZDBaseNavigationController *nav = self.viewControllers[itemIndex];
    if (nav.viewControllers.count == 0) {
        return;
    }
    nav.tabBarItem.badgeValue = badgeValue;
}

- (void)handle3DTouch:(NSNotification *)noti {
    NSLog(@"##############################3DTouch进入APP##############################");
    UIApplicationShortcutItem *item = noti.object;
    if ([item.localizedTitle isEqualToString:@"爱情"]) {
        [self setSelectedIndex:0];
        [self.selectedViewController native_pushViewController:[ZDTestViewController new] animated:YES];
    } else if ([item.localizedTitle isEqualToString:@"好友"]) {
        [self setSelectedIndex:1];
        [self.selectedViewController native_pushViewController:[ZDContactViewController new] animated:YES];
    }
}

@end

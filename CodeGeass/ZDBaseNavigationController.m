//
//  ZDBaseNavigationController.m
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ZDBaseNavigationController.h"

@interface ZDBaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, getter=isPushing) BOOL pushing;///< 是否正在push，防止网络不好，多次push同一个VC
@end

@implementation ZDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    [self customFullScreenPop];
    [self addDebugGestureRecognizer];
    self.delegate = self;
}

#pragma mark - Private

#pragma mark - Debug
- (void)addDebugGestureRecognizer{
#ifdef DEBUG
    // 长按导航栏弹出提示框，展示push的路径，用于调试
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showPushRouteAlert:)];
    [self.navigationBar addGestureRecognizer:longPress];
#endif
}

- (void)showPushRouteAlert:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSMutableString *string = [NSMutableString string];
        [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [string appendString:NSStringFromClass(obj.class)];
            if(idx != self.viewControllers.count - 1) {
                [string appendString:@"\n"];
            }
        }];
        ZDALERT(string, nil, @"确定");
    }
}

#pragma mark - StatusBar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - NavigationBar
- (void)customNavigationBar {
    UIImage *image = [UIImage imageWithColor:[UIColor zd_navBgColor] size:CGSizeMake(SCREEN_WIDTH, STATUS_AND_NAVIGATION_HEIGHT)];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 去掉系统的导航栏底部细线
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                               NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
}

#pragma mark - FullScreenPop
/**
 实现全屏右滑返回
 */
- (void)customFullScreenPop {

    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)handleNavigationTransition:(UIGestureRecognizer *)gestureRecognizer {}

// 当在第一个VC时需不能响应手势，不然会出现bug：在第一个VC先右滑然后push会卡住
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

// 解决在手指滑动时候，被pop的viewController中的UIscrollView会跟着一起滚动
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return [gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]];
//}

#pragma mark - Push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 假如项目架构为tabBar + Nav模式，那么在各个界面首页push到下一页时，隐藏tabBar
    // !self.tabBarController.tabBar.isHidden，修复：在tabBarController的一级VC里面使用searchVC时，会隐藏tabBar，点击搜索出来的数据进入下一个VC再返回tabBar会显示出来。也就是在tabBar已经隐藏时设置hidesBottomBarWhenPushed=YES会使返回时tabBar显示出来
    if (self.viewControllers.count == 1 && !self.tabBarController.tabBar.isHidden) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    if (self.isPushing) {
        NSLog(@"网络不好，拦截多次push同一个VC");
        return;
    } else {
        self.pushing = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)native_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1 && !self.tabBarController.tabBar.isHidden) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    self.pushing = NO;
}

@end

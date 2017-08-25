//
//  AppDelegate.m
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "AppDelegate.h"
#import <AvoidCrash.h>
#import <Appirater.h>
#import <Bugly/Bugly.h>
#import <IQKeyboardManager.h>
#import <OnboardingViewController.h>

#import "DebugHelper.h"
#import "YTKNetworkConfig.h"
#import "XHLaunchAd.h"

#import "ZDTabBarController.h"
#import "ZDLoginViewController.h"
#import "ZDRLMMigrationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 延长LaunchImage显示时间
//    sleep(2);
    
    
    // 初始化window
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // 配置
    [self setupAvoidCrash];
    [self setupAppirater];
    [self setupSVProgressHUD];
    [self setupLCActionSheet];
    [self setupIQKeyboardManager];
    [self setupYTKNetwork];
    [self setupBugly];
    //[[ZDRLMMigrationManager sharedManager] migration];
    [self setup3DTouch];
    
    
    
    if ([ZDCommonTool checkFirstLaunchingApplication]) {
        // 新手引导
        [self setupOnboard];
    } else {
        // 设置广告页
//        [self setupXHLaunchAd];
        
        NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentAccount"];
        NSString *password = [YYKeychain getPasswordForService:[UIApplication sharedApplication].appBundleName
                                                       account:account];
        if (password) {
            [[ZDUserManager sharedManager] loginWithAccount:account
                                                   password:password
                                                    success:nil
                                                    failure:nil];
            ZDTabBarController *tabBarController = [ZDTabBarController new];
            self.window.rootViewController = tabBarController;
        } else {
            ZDLoginViewController *loginVC = [ZDLoginViewController new];
            self.window.rootViewController = loginVC;
        }
    }
    
    // 设置开发调试工具
    [DebugHelper setup];
    

    


    return YES;
}

- (void)setup3DTouch {
    if ([UIApplication sharedApplication].shortcutItems.count == 0) {
        NSString *type = [NSString stringWithFormat:@"%@.shortcut",[[NSBundle mainBundle] bundleIdentifier]];
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.1",type] localizedTitle:@"好友" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact] userInfo:nil];
        UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.2",type] localizedTitle:@"工作" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeTask] userInfo:nil];
        UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.3",type] localizedTitle:@"家庭" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
        UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.4",type] localizedTitle:@"爱情" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove] userInfo:nil];
        [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3,item4];
    }
}

- (void)setupIQKeyboardManager {
//    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;
}

- (void)setupBugly {
    // 集成腾讯Bugly，错误上报
    [Bugly startWithAppId:@"3be0c92857"];
}

- (void)setupXHLaunchAd {
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image0.jpg";
    imageAdconfiguration.openURLString = @"http://www.returnoc.com";
    imageAdconfiguration.duration = 3;
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

- (void)setupLCActionSheet {
    LCActionSheetConfig *config = [LCActionSheetConfig config];
    config.titleFont = [UIFont systemFontOfSize:15];
    config.titleColor = [UIColor zd_mainContentColor];
    config.buttonFont = [UIFont systemFontOfSize:17];
    config.buttonColor = [UIColor zd_mainTitleColor];
    config.darkOpacity = 0.5;
}

- (void)setupAvoidCrash {
    [AvoidCrash becomeEffective];
    
#ifdef DEBUG
    // 监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
#endif
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}

- (void)setupYTKNetwork {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = HTTP_HOST;
#ifdef DEBUG
    config.debugLogEnabled = YES;
#endif
}

- (void)setupAppirater {
    // APP评分提示框
    // 设置AppId，用于跳转到AppStore
    [Appirater setAppId:[UIApplication sharedApplication].appBundleName];
    // 安装后几天后才提示
    [Appirater setDaysUntilPrompt:0];
    // 使用几次后才提示，必须调用appLaunched、appEnteredForeground
    [Appirater setUsesUntilPrompt:3];
    [Appirater setSignificantEventsUntilPrompt:-1];
    // 用户点击“以后再说”，几天后才提示
    [Appirater setTimeBeforeReminding:2];
    [Appirater appLaunched:YES];
}

- (void)setupSVProgressHUD {
    // 配置SVProgressHUD
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.8]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
//    CGFloat width = GOLD_SCALE_SHORT(SCREEN_WIDTH);
//    [SVProgressHUD setMinimumSize:CGSizeMake(width, GOLD_SCALE_LONG(width))];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];
    [SVProgressHUD setCornerRadius:8];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"hud_success"]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"hud_error"]];
}

- (void)setupOnboard {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"ec欢迎您1" body:@"hello world" image:nil buttonText:@"登录" action:^{
        self.window.rootViewController = [ZDLoginViewController new];
    }];
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"ec欢迎您2" body:@"hello world" image:nil buttonText:@"登录" action:^{
        self.window.rootViewController = [ZDLoginViewController new];
    }];
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"ec欢迎您3" body:@"hello world" image:nil buttonText:@"登录" action:^{
        self.window.rootViewController = [ZDLoginViewController new];
    }];
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"newcomer_guide"] contents:@[firstPage, secondPage, thirdPage]];
//    onboardingVC.shouldBlurBackground = YES;
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.allowSkipping = YES;
    onboardingVC.fadeSkipButtonOnLastPage = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    self.window.rootViewController = onboardingVC;
}


- (void)changeRootViewController:(UIViewController *)viewController {
    self.window.rootViewController = viewController;
#ifdef DEBUG
    [self.window bringSubviewToFront:[DebugHelper sharedInstance].debugLabel];
    [self.window bringSubviewToFront:[DebugHelper sharedInstance].fpsLabel];
#endif
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [Appirater appEnteredForeground:YES];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

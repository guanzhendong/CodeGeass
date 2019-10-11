//
//  ZDBaseViewController.m
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ZDBaseViewController.h"

@interface ZDBaseViewController ()

@end

@implementation ZDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor zd_backgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.navigationController.viewControllers.count > 1) {
//        [self createLeftButtonWithImage:@"navigation_back_white" action:@selector(navigationControllerPop)];
        
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        // 上一个VC
        UIViewController *preVC = [self.navigationController.viewControllers sa_objectAtIndex:index - 1];
        [self createBackButtonWithTitle:preVC.title ? : @"返回"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"进入:%@",NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    [SVProgressHUD dismiss];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 解决peek出来的VC“返回”按钮为系统蓝色的问题
    if (self.navigationController.viewControllers.count > 1) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        // 上一个VC
        UIViewController *preVC = [self.navigationController.viewControllers sa_objectAtIndex:index - 1];
        [self createBackButtonWithTitle:preVC.title ? : @"返回"];
    }
}

- (void)dealloc {
    NSLog(@"释放:%@",NSStringFromClass([self class]));
}

- (void)navigationControllerPop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createRightButtonWithTitle:(NSString *)title action:(SEL)action {
    NSMutableArray *array = [NSMutableArray array];
    if (self.navigationItem.rightBarButtonItem) {
        array = [self.navigationItem.rightBarButtonItems mutableCopy];
    }
//    UIBarButtonItem *item = [UIBarButtonItem itemWithTitle:title
//                                                    target:self
//                                                    action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:.3]} forState:UIControlStateDisabled];
    [array addObject:item];
    self.navigationItem.rightBarButtonItems = array;
}

- (void)createRightButtonWithImage:(NSString *)image action:(SEL)action {
    NSMutableArray *array = [NSMutableArray array];
    if (self.navigationItem.rightBarButtonItem) {
        array = [self.navigationItem.rightBarButtonItems mutableCopy];
    }
//    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:image
//                                                    target:self
//                                                    action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    [array addObject:item];
    self.navigationItem.rightBarButtonItems = array;
}

- (void)createLeftButtonWithTitle:(NSString *)title action:(SEL)action {
    NSMutableArray *array = [NSMutableArray array];
    if (self.navigationItem.rightBarButtonItem) {
        array = [self.navigationItem.rightBarButtonItems mutableCopy];
    }
//    UIBarButtonItem *item = [UIBarButtonItem itemWithTitle:title
//                                                    target:self
//                                                    action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:.3]} forState:UIControlStateDisabled];
    [array addObject:item];
    self.navigationItem.leftBarButtonItems = array;
}

- (void)createLeftButtonWithImage:(NSString *)image action:(SEL)action {
    NSMutableArray *array = [NSMutableArray array];
    if (self.navigationItem.rightBarButtonItem) {
        array = [self.navigationItem.rightBarButtonItems mutableCopy];
    }
//    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:image
//                                                    target:self
//                                                    action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    [array addObject:item];
    self.navigationItem.leftBarButtonItems = array;
}

#pragma mark - Private

// 创建导航返回按钮，样式是左arrow右标题，类似微信QQ
- (void)createBackButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setImage:[UIImage imageNamed:@"navBar_back_white"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 12)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [button addTarget:self action:@selector(navigationControllerPop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

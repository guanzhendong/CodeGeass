//
//  ZDTranslucentViewController.h
//  CodeGeass
//
//  Created by ec on 2017/5/9.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/*
 App中会经常需要在透明与不透明 NavigationBar 的页面相互切换。有些时候在透明 NavigationBar 页面甚至还需要根据 scrollView 的 contentOffset 来动态调整 NavigationBar 的透明度。此类用于解决这个问题
 */

#import "ZDBaseViewController.h"

@interface ZDTranslucentViewController : ZDBaseViewController

/**
 透明的导航栏，可在子类自定义，设置backgroundColor，alpha等
 */
@property (nonatomic, strong) UINavigationBar *translucentNavigationBar;


/**
 子类重写，在需要透明的类中返回YES

 @return BOOL
 */
- (BOOL)isTranslucentNavBar;

@end

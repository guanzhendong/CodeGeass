//
//  UIColor+ZDCustom.h
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZDCustom)

/**
 导航栏背景色（黑）

 @return 303642
 */
+ (UIColor *)zd_navBgColor;

/**
 主题绿色
 
 @return 0DC88C
 */
+ (UIColor *)zd_greenThemeColor;

/**
 主题黑色
 
 @return 303642
 */
+ (UIColor *)zd_blackThemeColor;

/**
 主要标题颜色（黑）
 
 @return 303642
 */
+ (UIColor *)zd_mainTitleColor;

/**
 一般背景色（例如VC的背景色）
 
 @return F0F2F4
 */
+ (UIColor *)zd_backgroundColor;

/**
 一般分隔线色（例如tableView分隔线）
 
 @return D5DBE1
 */
+ (UIColor *)zd_separatorColor;

/**
 主要内容颜色（褐）

 @return 81878E
 */
+ (UIColor *)zd_mainContentColor;

/**
 次要内容颜色（浅褐色）（例如时间信息）

 @return 9FA2A7
 */
+ (UIColor *)zd_secondaryContentColor;

@end

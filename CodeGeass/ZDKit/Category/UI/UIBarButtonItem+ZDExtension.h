//
//  UIBarButtonItem+ZDExtension.h
//  CodeGeass
//
//  Created by ec on 2017/1/4.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZDExtension)

/**
 font=16,白色
 */
+ (instancetype)itemWithTitle:(NSString *)title
                       target:(id)target
                       action:(SEL)action;

/**
 可自定义title的富文本
 */
+ (instancetype)itemWithTitle:(NSString *)title
                   attributes:(NSDictionary *)attributes
                       target:(id)target
                       action:(SEL)action;


/**
 使用initWithCustomView
 */
+ (instancetype)itemWithImage:(NSString *)image
                       target:(id)target
                       action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image
             highlightedImage:(NSString *)highlightedImage
                       target:(id)target
                       action:(SEL)action;

@end

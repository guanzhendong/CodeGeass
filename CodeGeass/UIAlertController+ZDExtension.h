//
//  UIAlertController+ZDExtension.h
//  CodeGeass
//
//  Created by ec on 2017/5/26.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/**
 自定义UIAlertController的title、message、button的颜色
 */

#import <UIKit/UIKit.h>

@interface UIAlertAction (ZDExtension)

- (void)zd_setTitleColor:(UIColor *)color;

@end

@interface UIAlertController (ZDExtension)

- (void)zd_setTitleColor:(UIColor *)color;

- (void)zd_setAttributedTitle:(NSAttributedString *)title;

- (void)zd_setMessageColor:(UIColor *)color;

- (void)zd_setAttributedMessage:(NSAttributedString *)message;

- (void)zd_setActionTitleColor:(UIColor *)color;

@end

//
//  UITextView+ZDKeyboard.h
//  CodeGeass
//
//  Created by ec on 2017/4/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/**
 处理UITextView内容被键盘遮盖的问题
 */

#import <UIKit/UIKit.h>

@interface UITextView (ZDKeyboard)

- (void)zd_setupKeyboardAvoid;

@end

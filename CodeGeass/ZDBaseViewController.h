//
//  ZDBaseViewController.h
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDBaseViewController : UIViewController

- (void)createRightButtonWithTitle:(NSString *)title action:(SEL)action;
- (void)createRightButtonWithImage:(NSString *)image action:(SEL)action;

- (void)createLeftButtonWithTitle:(NSString *)title action:(SEL)action;
- (void)createLeftButtonWithImage:(NSString *)image action:(SEL)action;


/**
 导航返回，提供给子类重写
 */
- (void)navigationControllerPop;

@end

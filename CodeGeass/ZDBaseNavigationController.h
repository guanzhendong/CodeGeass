//
//  ZDBaseNavigationController.h
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDBaseNavigationController : UINavigationController

- (void)native_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

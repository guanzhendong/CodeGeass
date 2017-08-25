//
//  ZDTabBarController.h
//  CodeGeass
//
//  Created by ec on 2016/12/28.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDTabBarController : UITabBarController


/**
 设置标签栏小红点

 @param badgeValue 标记值
 @param itemIndex 小红点位置
 */
- (void)setTabBarItemBadgeValue:(NSString *)badgeValue
                      itemIndex:(NSUInteger)itemIndex;

@end

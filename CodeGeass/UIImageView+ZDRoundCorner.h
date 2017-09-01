//
//  UIImageView+ZDRoundCorner.h
//  CodeGeass
//
//  Created by ec on 2017/9/1.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

// 效果有延迟，设置图片不能和cell点击时背景色同步，这也不是一个好方案，所以还是用系统的切圆角来做，并不会造成太大的消耗

#import <UIKit/UIKit.h>

@interface UIImageView (ZDRoundCorner)

/**
 是否支持圆角
 */
@property (nonatomic, assign) BOOL zd_roundCornerEnabled;

@property (nonatomic, weak, readonly) CALayer *zd_roundCornerLayer;

@end

//
//  UIButton+ZDAddForTouchArea.h
//  CodeGeass
//
//  Created by ec on 2018/2/11.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZDAddForTouchArea)

/**
 设置按钮额外热区，top, left, bottom, right
 */
@property (nonatomic, assign) UIEdgeInsets zd_touchAreaInsets;

/**
 设置按钮额外热区，中心点不变，设置更大的宽、高
 */
@property (nonatomic, assign) CGSize zd_touchSize;


@end

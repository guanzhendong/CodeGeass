//
//  UIButton+ZDAddForTouchArea.m
//  CodeGeass
//
//  Created by ec on 2018/2/11.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "UIButton+ZDAddForTouchArea.h"
#import <objc/runtime.h>

@implementation UIButton (ZDAddForTouchArea)

- (UIEdgeInsets)zd_touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(zd_touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setZd_touchAreaInsets:(UIEdgeInsets)zd_touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:zd_touchAreaInsets];
    objc_setAssociatedObject(self, @selector(zd_touchAreaInsets), value, OBJC_ASSOCIATION_ASSIGN);
}

- (CGSize)zd_touchSize {
    return [objc_getAssociatedObject(self, @selector(zd_touchSize)) CGSizeValue];
}

- (void)setZd_touchSize:(CGSize)zd_touchSize {
    NSValue *value = [NSValue valueWithCGSize:zd_touchSize];
    objc_setAssociatedObject(self, @selector(zd_touchSize), value, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    UIEdgeInsets touchAreaInsets = self.zd_touchAreaInsets;
    
    // 没有设置zd_touchAreaInsets
    if (UIEdgeInsetsEqualToEdgeInsets(touchAreaInsets, UIEdgeInsetsZero)) {
        CGSize touchSize = self.zd_touchSize;
        CGRect touchBounds = CGRectMake(0, 0, touchSize.width, touchSize.height);
        // 没有设置zd_touchSize
        if (CGSizeEqualToSize(touchSize, CGSizeZero)) {
            return [super pointInside:point withEvent:event];
        } else if (CGRectContainsRect(touchBounds, bounds)) {// zd_touchSize大于自身bounds
            bounds = CGRectMake(- (touchBounds.size.width - bounds.size.width) / 2,
                                - (touchBounds.size.height - bounds.size.height) / 2,
                                touchBounds.size.width,
                                touchBounds.size.height);
            return CGRectContainsPoint(bounds, point);
        } else {
            return [super pointInside:point withEvent:event];
        }
    } else {// 设置了zd_touchAreaInsets
        bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                            bounds.origin.y - touchAreaInsets.top,
                            bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                            bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
        return CGRectContainsPoint(bounds, point);
    }
    return [super pointInside:point withEvent:event];
}

@end

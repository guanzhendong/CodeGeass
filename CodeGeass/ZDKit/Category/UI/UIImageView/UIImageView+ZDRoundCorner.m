//
//  UIImageView+ZDRoundCorner.m
//  CodeGeass
//
//  Created by ec on 2017/9/1.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIImageView+ZDRoundCorner.h"

@implementation UIImageView (ZDRoundCorner)

static const void *zd_roundCornerEnabledKey = &zd_roundCornerEnabledKey;
- (BOOL)zd_roundCornerEnabled {
    return [objc_getAssociatedObject(self, zd_roundCornerEnabledKey) boolValue];
}

- (void)setZd_roundCornerEnabled:(BOOL)zd_roundCornerEnabled {
    objc_setAssociatedObject(self, zd_roundCornerEnabledKey, @(zd_roundCornerEnabled), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setHighlighted:(BOOL)highlighted {
    if (self.zd_roundCornerEnabled) {
        if (highlighted) {
            self.zd_roundCornerLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"imageView_roundCorner_highlighted"].CGImage);
        } else {
            self.zd_roundCornerLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"imageView_roundCorner_normal"].CGImage);
        }
    }
}

- (CALayer *)zd_roundCornerLayer {
    CALayer *layer = objc_getAssociatedObject(self, @selector(zd_roundCornerLayer));
    if (!layer) {
        layer = [CALayer layer];
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"imageView_roundCorner_normal"].CGImage);
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, @selector(zd_roundCornerLayer), layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.clipsToBounds = YES;
    }
    return layer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.zd_roundCornerEnabled) {
        self.zd_roundCornerLayer.frame = self.bounds;
    }
}

@end

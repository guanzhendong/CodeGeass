//
//  UITableView+ZDFitForIOS11.m
//  CodeGeass
//
//  Created by ec on 2017/10/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UITableView+ZDFitForIOS11.h"

@implementation UITableView (ZDFitForIOS11)

+ (void)load {
    [self swizzleInstanceMethod:@selector(initWithFrame:style:) with:@selector(zd_initWithFrame:style:)];
}

- (instancetype)zd_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.scrollIndicatorInsets = self.contentInset;
    }
    return [self zd_initWithFrame:frame style:style];
}

@end

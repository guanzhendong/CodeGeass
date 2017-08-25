//
//  UIScrollView+ZDRefresh.h
//  CodeGeass
//
//  Created by ec on 2017/4/28.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/*
 封装MJRefresh，提供通用的下拉刷新，上拉加载
 */

#import <UIKit/UIKit.h>

@interface UIScrollView (ZDRefresh)

- (void)zd_setupHeaderWithRefreshingBlock:(dispatch_block_t)block;

- (void)zd_setupFooterWithRefreshingBlock:(dispatch_block_t)block;

@end

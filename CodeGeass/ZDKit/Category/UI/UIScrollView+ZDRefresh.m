//
//  UIScrollView+ZDRefresh.m
//  CodeGeass
//
//  Created by ec on 2017/4/28.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIScrollView+ZDRefresh.h"

@implementation UIScrollView (ZDRefresh)

- (void)zd_setupHeaderWithRefreshingBlock:(dispatch_block_t)block {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) block();
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    [header setTitle:@"下拉" forState:MJRefreshStateIdle];
    [header setTitle:@"松开" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

- (void)zd_setupFooterWithRefreshingBlock:(dispatch_block_t)block {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (block) block();
    }];
    footer.automaticallyHidden = YES;
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    [footer setTitle:@"上拉" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

@end

//
//  UITableView+ZDPlaceholder.m
//  CodeGeass
//
//  Created by ec on 2017/4/1.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UITableView+ZDPlaceholder.h"

@implementation UITableView (ZDPlaceholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self swizzleInstanceMethod:@selector(reloadData) with:@selector(zd_reloadData)];
    });
}

- (void)zd_reloadData {
    if (!self.zd_firstReload) {
        [self checkEmpty];
    }
    self.zd_firstReload = NO;
    [self zd_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES;//flag标示
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;//默认一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前TableView各组行数
        if (rows) {
            isEmpty = NO;//若行数存在，不为空
        }
    }
    if (isEmpty) {//若为空，加载占位图
        if ([YYReachability reachability].isReachable) {// 有网络，显示无数据占位图
            //默认占位图
            if (!self.zd_noDataPlaceholder) {
                [self setupDefaultNoDataPlaceholder];
            }
            self.zd_noDataPlaceholder.hidden = NO;
            [self addSubview:self.zd_noDataPlaceholder];
        } else {                                        // 无网络，显示无网络占位图
            if (!self.zd_noNetworkPlaceholder) {
                [self setupDefaultNoNetworkPlaceholder];
            }
            self.zd_noNetworkPlaceholder.hidden = NO;
            [self addSubview:self.zd_noNetworkPlaceholder];
        }
    } else {//不为空，移除占位图
        self.zd_noDataPlaceholder.hidden = YES;
        self.zd_noNetworkPlaceholder.hidden = YES;
    }
}

- (void)setupDefaultNoDataPlaceholder {
    UIView *defaultPlaceholder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    defaultPlaceholder.backgroundColor = [UIColor zd_backgroundColor];
    [self addSubview:defaultPlaceholder];
    self.zd_noDataPlaceholder = defaultPlaceholder;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_placeholder_default"]];
    imageView.bounds = CGRectMake(0, 0, SCALE(130), SCALE(130));
    imageView.center = defaultPlaceholder.center;
    [defaultPlaceholder addSubview:imageView];
}

- (void)setupDefaultNoNetworkPlaceholder {
    UIView *defaultPlaceholder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    defaultPlaceholder.backgroundColor = [UIColor zd_backgroundColor];
    [self addSubview:defaultPlaceholder];
    self.zd_noNetworkPlaceholder = defaultPlaceholder;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.center = defaultPlaceholder.center;
    label.text = @"网络连接断开，请检查网络";
    [defaultPlaceholder addSubview:label];
}

#pragma mark - associatedObject

static const void *zd_noDataPlaceholderKey = &zd_noDataPlaceholderKey;
- (UIView *)zd_noDataPlaceholder {
    return objc_getAssociatedObject(self, zd_noDataPlaceholderKey);
}

- (void)setZd_noDataPlaceholder:(UIView *)zd_noDataPlaceholder {
    objc_setAssociatedObject(self, zd_noDataPlaceholderKey, zd_noDataPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const void *zd_noNetworkPlaceholderKey = &zd_noNetworkPlaceholderKey;
- (UIView *)zd_noNetworkPlaceholder {
    return objc_getAssociatedObject(self, zd_noNetworkPlaceholderKey);
}

- (void)setZd_noNetworkPlaceholder:(UIView *)zd_noNetworkPlaceholder {
    objc_setAssociatedObject(self, zd_noNetworkPlaceholderKey, zd_noNetworkPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const void *zd_firstReloadKey = &zd_firstReloadKey;
- (BOOL)zd_firstReload {
    return [objc_getAssociatedObject(self, zd_firstReloadKey) boolValue];
}

- (void)setZd_firstReload:(BOOL)zd_firstReload {
    objc_setAssociatedObject(self, zd_firstReloadKey, @(zd_firstReload), OBJC_ASSOCIATION_ASSIGN);
}

static const void *zd_defaultPlaceholderClickedBlockKey = &zd_defaultPlaceholderClickedBlockKey;
- (void (^)())zd_defaultPlaceholderClickedBlock {
    return objc_getAssociatedObject(self, zd_defaultPlaceholderClickedBlockKey);
}

- (void)setZd_defaultPlaceholderClickedBlock:(void (^)())zd_defaultPlaceholderClickedBlock {
    objc_setAssociatedObject(self, zd_defaultPlaceholderClickedBlockKey, zd_defaultPlaceholderClickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end

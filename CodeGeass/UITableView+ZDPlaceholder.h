//
//  UITableView+ZDPlaceholder.h
//  CodeGeass
//
//  Created by ec on 2017/4/1.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

// 弃用，EC里面的比较好，使用UIView的分类，为了这个简单的功能来swizzle reloadData方法不值得

#import <UIKit/UIKit.h>

@interface UITableView (ZDPlaceholder)

/**
 首次网络请求未完成占位图显示问题 因tableView、collectionView在创建后系统会默认调用一次reloadData，所以会出现网络请求未完成即展示占位图的问题。若希望在首次网络请求未完成时不显示占位图，可将zd_firstReload置为YES即可
 */
@property (nonatomic, assign) BOOL zd_firstReload;

/**
 tableView无数据占位图，由外面自定义，若没有则显示默认的
 */
@property (nonatomic, strong) UIView *zd_noDataPlaceholder;

/**
 tableView无网络占位图，由外面自定义，若没有则显示默认的
 */
@property (nonatomic, strong) UIView *zd_noNetworkPlaceholder;

@property (nonatomic,   copy) void (^zd_defaultPlaceholderClickedBlock)();

@end

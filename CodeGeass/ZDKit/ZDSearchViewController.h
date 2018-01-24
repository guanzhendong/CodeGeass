//
//  ZDSearchViewController.h
//  CodeGeass
//
//  Created by ec on 2017/3/30.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/*
 * 通用的搜索控制器，数据由tableView在外部设置
 */

#import "ZDBaseViewController.h"

@class ZDSearchViewController;

@protocol ZDSearchViewControllerDelegate <NSObject>

- (void)searchVCCancelButtonClicked:(ZDSearchViewController *)searchVC;

- (void)searchVC:(ZDSearchViewController *)searchVC textDidChange:(NSString *)searchText;

@end

@interface ZDSearchViewController : ZDBaseViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<ZDSearchViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *placeholder;

- (instancetype)initWithParentVC:(UIViewController *)parentVC;

- (void)show;

- (void)hide;

@end

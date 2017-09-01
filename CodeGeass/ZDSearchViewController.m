//
//  ZDSearchViewController.m
//  CodeGeass
//
//  Created by ec on 2017/3/30.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDSearchViewController.h"
#import "ZDTranslucentViewController.h"

@interface ZDSearchViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) BOOL isTabBarHidden;
@property (nonatomic, assign) BOOL isNavBarHidden;
@property (nonatomic, assign) BOOL isTranslucentParentVC;
@property (nonatomic, weak) ZDTranslucentViewController *translucentParentVC;// 使用strong的话，toolVC引用了searchVC，searchVC引用了toolVC，会无法释放
@end

@implementation ZDSearchViewController

- (instancetype)initWithParentVC:(UIViewController *)parentVC {
    self = [super init];
    if (self) {
        if (!parentVC) {
            return nil;
        }
        [parentVC addChildViewController:self];
        [parentVC.view addSubview:self.view];
        self.view.hidden = YES;
        _delegate = (id)parentVC;
        _isTranslucentParentVC = [parentVC isKindOfClass:[ZDTranslucentViewController class]];
        if (_isTranslucentParentVC) {
            _translucentParentVC = (ZDTranslucentViewController *)parentVC;
        }
    }
    return self;
}

- (void)show {
    self.view.hidden = NO;
    [_searchBar becomeFirstResponder];

    _isNavBarHidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _isTabBarHidden = self.tabBarController.tabBar.isHidden;
    self.tabBarController.tabBar.hidden = YES;
    
    if (_isTranslucentParentVC) {
        [UIView animateWithDuration:0.2 animations:^{
            _translucentParentVC.translucentNavigationBar.bottom = 0;
        }];
    }
}

- (void)hide {
    self.view.hidden = YES;
    _searchBar.text = nil;
    [_searchBar resignFirstResponder];
    
    [self.navigationController setNavigationBarHidden:_isNavBarHidden animated:YES];
    self.tabBarController.tabBar.hidden = _isTabBarHidden;
    
    if (_isTranslucentParentVC) {
        [UIView animateWithDuration:0.2 animations:^{
            _translucentParentVC.translucentNavigationBar.bottom = STATUS_AND_NAVIGATION_HEIGHT;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    searchView.backgroundColor = [UIColor zd_backgroundColor];
    [self.view addSubview:searchView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 46, searchView.bounds.size.height)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    _searchBar.tintColor = [UIColor zd_greenThemeColor];
    _searchBar.backgroundImage = [UIImage new];// 去除掉top、bottom的细线
    _searchBar.backgroundColor = [UIColor zd_backgroundColor];// 这两行顺序不能颠倒
    [searchView addSubview:_searchBar];
//    _searchBar.showsCancelButton = YES;//UISearchBar自带的cancel按钮有个问题：关闭键盘后变成了不能点击的状态，改用自定义
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) + 3, 0, 35, searchView.bounds.size.height);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancel addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancel];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _searchBar.placeholder = placeholder;
}

- (void)cancelButtonClicked {
    [self hide];
    
    if ([_delegate respondsToSelector:@selector(searchVCCancelButtonClicked:)]) {
        [_delegate searchVCCancelButtonClicked:self];
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self hide];
    
    if ([_delegate respondsToSelector:@selector(searchVCCancelButtonClicked:)]) {
        [_delegate searchVCCancelButtonClicked:self];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([_delegate respondsToSelector:@selector(searchVC:textDidChange:)]) {
        [_delegate searchVC:self textDidChange:searchText];
    }
}

@end

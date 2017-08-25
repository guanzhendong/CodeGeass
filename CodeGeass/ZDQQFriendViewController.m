//
//  ZDQQFriendViewController.m
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDQQFriendViewController.h"
#import "ZDQQFriendManager.h"
#import "FoldedTableViewHeaderFooterView.h"

@interface ZDQQFriendViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation ZDQQFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QQ好友";
    
//    [[ZDQQFriendManager sharedManager] requestQQFriendGroupWithSuccess:nil failure:nil];
//    [[ZDQQFriendManager sharedManager] requestQQFriendWithPage:0 success:nil failure:nil];
    [self initUI];
    [self initData];
}

- (void)initData {
    _tableData = [[ZDQQFriendManager sharedManager] allQQFriendGroups].mutableCopy;
    for (ZDQQFriendGroup *group in _tableData) {
        group.friends = [[ZDQQFriendManager sharedManager] QQFriendsWithGroupId:group.Id];
    }
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    _tableView.sectionHeaderHeight = 50;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor zd_separatorColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"CGCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"CGCommonTableViewCell1"];
    [_tableView registerClass:[FoldedTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"FoldedTableViewHeaderFooterView"];
    [self.view addSubview:_tableView];
    
    
    UISearchBar *bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    bar.placeholder = @"搜索";
    _tableView.tableHeaderView = bar;
    bar.backgroundImage = [UIImage new];// 去除掉top、bottom的细线
    bar.backgroundColor = [UIColor zd_backgroundColor];// 这两行顺序不能颠倒
    bar.userInteractionEnabled = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZDQQFriendGroup *model = self.tableData[section];
    return model.isExpanded ? model.friends.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"CGCommonTableViewCell1" forIndexPath:indexPath];
    ZDQQFriendGroup *model = self.tableData[indexPath.section];
    ZDQQFriend *friend = model.friends[indexPath.row];
    cell.topLabel.text = friend.remark;
    cell.bottomLabel.text = friend.name;
    [cell.leftImageView setImageWithURL:[NSURL URLWithString:friend.face]
                            placeholder:[UIImage zd_middleImageWithText:friend.remark]
                                options:0
                               progress:nil
                              transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                  return [image imageByRoundCornerRadius:image.size.width];
                              } completion:nil];
    cell.leftImageViewHeightConstraint.constant = 36;
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FoldedTableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FoldedTableViewHeaderFooterView"];
    ZDQQFriendGroup *model = self.tableData[section];
    [view setupWithModel:model section:section didSelectBlock:^{
        [tableView reloadData];
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

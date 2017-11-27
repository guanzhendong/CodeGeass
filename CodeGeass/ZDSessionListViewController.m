//
//  ZDSessionListViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDSessionListViewController.h"
#import "ZDTestViewController.h"
#import "ZDSessionManager.h"
#import "ZDCorpManager.h"
#import "ZDGroupManager.h"
#import "YYImageCache+ZDGroupIconCache.h"
#import "QQPopMenuView.h"
#import "ODRefreshControl.h"

@interface ZDSessionListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation ZDSessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLeftButtonWithTitle:@"测试" action:@selector(pushToTestVC)];
    [self createRightButtonWithImage:@"navBar_add_white" action:@selector(presentMenu)];

    
    NSLog(@"%@",[UIApplication sharedApplication].documentsPath);
    
    
    [self initUI];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initData];
    });
}

- (void)initData {
    _tableData = [[ZDSessionManager sharedManager] allSessions].mutableCopy;
    [_tableView reloadData];
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell1"];
    [self.view addSubview:_tableView];
    
    
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDCommonTableViewCell1 *cell = [_tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1" forIndexPath:indexPath];
    ZDSessionModel *model = _tableData[indexPath.row];
    NSString *title;
    NSString *content;
    if (model.type == ZDSessionDataTypeSingle) {
        ZDEmployeeModel *employee = [[ZDCorpManager sharedManager] employeeWithId:model.Id];
        title = employee.name;
        content = model.content;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:employee.face]
                                placeholder:nil
                                    options:0
                                   progress:nil
                                  transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                      return [image imageByRoundCornerRadius:image.size.width];
                                  } completion:nil];
    } else {
        ZDGroupDataType type = model.type == ZDSessionDataTypeGroup ? ZDGroupDataTypeGroup : ZDGroupDataTypeDiscuss;
        ZDGroupModel *group = [[ZDGroupManager sharedManager] groupWithId:model.Id type:type];
        title = group.name;
        content = [NSString stringWithFormat:@"%@：%@",[[ZDCorpManager sharedManager] employeeWithId:model.talkId].name,model.content];
        if ([[YYImageCache groupIconCache] containsImageForKey:[NSString stringWithFormat:@"%@_%@",ZD_USERID,model.Id]]) {
            cell.leftImageView.image = [[YYImageCache groupIconCache] getImageForKey:[NSString stringWithFormat:@"%@_%@",ZD_USERID,model.Id]];
        } else {
            [model.downloader startWithId:model.Id type:type success:^(UIImage *image) {
                cell.leftImageView.image = image;
            }];
        }
    }
    cell.leftImageViewHeightConstraint.constant = 50;
    cell.topLabel.text = title;
    cell.bottomLabel.text = content;
    if (indexPath.row == _tableData.count - 1) {
        cell.showsSeparator = NO;
    } else {
        cell.showsSeparator = YES;
    }
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
//    action1.backgroundColor = [UIColor lightGrayColor];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标记未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action2.backgroundColor = [UIColor orangeColor];
    WEAKSELF
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        STRONGSELF
        [strongSelf.tableView beginUpdates];
        [strongSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [strongSelf.tableData sa_removeObjectAtIndex:indexPath.row];
        [strongSelf.tableView endUpdates];
    }];
//    action3.backgroundColor = [UIColor redColor];
    return @[action3,action2,action1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    } else if (indexPath.row == 1) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    } else {
        [SVProgressHUD showWithStatus:@"正在登录..."];
    }
}

- (void)pushToTestVC {
    ZDTestViewController *testVC = [ZDTestViewController new];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)presentMenu {
    [QQPopMenuView showWithItems:@[@{@"title":@"发起讨论",@"imageName":@"popMenu_createChat"},
                                   @{@"title":@"扫描名片",@"imageName":@"popMenu_scanCard"},
                                   @{@"title":@"写日报",@"imageName":@"popMenu_writeReport"},
                                   @{@"title":@"外勤签到",@"imageName":@"popMenu_signIn"}]
                           width:130
                triangleLocation:CGPointMake(SCREEN_WIDTH - 30, STATUS_AND_NAVIGATION_HEIGHT + 5)
                          action:^(NSInteger index) {
                              NSLog(@"点击了第%ld行",index);
                              switch (index) {
                                  case 0:
                                  {
                                      AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"https://www.baidu.com"];
                                      //webVC.navigationType = 1;
                                      [self.navigationController pushViewController:webVC animated:YES];
                                  }
                                      break;
                                      
                                  default:
                                      break;
                              }
                          }];
}

- (void)pullToRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_refreshControl endRefreshingWithStyle:ODEndRefreshStyleSuccess];
    });
}

@end

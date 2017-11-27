//
//  ZDCrmViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCrmViewController.h"
#import "ZDCrmManager.h"
#import "ZDSearchViewController.h"
#import "ZDContactViewController.h"

@interface ZDCrmViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ZDSearchViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) ZDSearchViewController *searchVC;
@property (nonatomic, strong) NSMutableArray *searchData;
@end

@implementation ZDCrmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    [self createRightButtonWithTitle:@"通讯录" action:@selector(gotoContactVC)];
}

- (void)gotoContactVC {
    ZDContactViewController *vc = [ZDContactViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData {
//    _tableData = [[ZDCrmManager sharedManager] allCrms].mutableCopy;
    _tableData = [NSMutableArray array];
    [_tableData addObject:[[ZDCrmManager sharedManager] allMineCrms]];
    [_tableData addObject:[[ZDCrmManager sharedManager] allShareCrms]];
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT, 0);// 设置contentInset可以使用毛玻璃效果
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell1"];
    [self.view addSubview:_tableView];
    
    WEAKSELF
    [_tableView zd_setupHeaderWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONGSELF
            [strongSelf.tableView.mj_header endRefreshing];
        });
    }];
    [_tableView zd_setupFooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONGSELF
            [strongSelf.tableView.mj_footer endRefreshing];
        });
    }];
    
    
    UISearchBar *bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    bar.placeholder = @"搜索";
    bar.delegate = self;
    _tableView.tableHeaderView = bar;
    bar.backgroundImage = [UIImage new];// 去除掉top、bottom的细线
    bar.backgroundColor = [UIColor zd_backgroundColor];// 这两行顺序不能颠倒
    
    
    _searchVC = [[ZDSearchViewController alloc] initWithParentVC:self];
    _searchVC.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _searchVC.tableView.delegate = self;
    _searchVC.tableView.dataSource = self;
    _searchVC.tableView.rowHeight = 70;
    _searchVC.tableView.backgroundColor = [UIColor zd_backgroundColor];
    _searchVC.placeholder = @"搜索客户名字、职位、手机号";
    _searchVC.tableView.tableFooterView = [UIView new];
    _searchVC.tableView.separatorColor = [UIColor zd_separatorColor];
    [_searchVC.tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell1Search"];
    [_searchVC.view addSubview:_searchVC.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return _tableData.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return [(NSArray *)_tableData[section] count];
    }
    return _searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        ZDCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1" forIndexPath:indexPath];
        ZDCrmModel *model = _tableData[indexPath.section][indexPath.row];;
        cell.topLabel.text = model.name;
//        [cell.leftImageView setImageWithURL:[NSURL URLWithString:model.face]
//                                placeholder:[UIImage zd_middleImageWithText:model.name]
//                                    options:0
//                                   progress:nil
//                                  transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
//                                      image = [image imageByResizeToSize:CGSizeMake(150, 150) contentMode:UIViewContentModeScaleAspectFill];
//                                      image = [image imageByRoundCornerRadius:image.size.width];// 不能只能调用这句，还要调用上句，image可能是长方形，当头像是长方形时，此句会返回椭圆形，这两句一起可以保证返回的图片是圆形
//                                      return image;
//                                  } completion:nil];
        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage zd_middleImageWithText:model.name]];
        cell.leftImageViewHeightConstraint.constant = 50;
        cell.leftImageView.clipsToBounds = YES;
        cell.leftImageView.layer.cornerRadius = 25;
        cell.bottomLabel.text = model.position;
        return cell;
    } else {
        ZDCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1Search" forIndexPath:indexPath];
        ZDEmployeeModel *model = _searchData[indexPath.row];
        cell.topLabel.text = model.name;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:model.face]
                                placeholder:[UIImage zd_middleImageWithText:model.name]
                                    options:0
                                   progress:nil
                                  transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                      image = [image imageByResizeToSize:CGSizeMake(150, 150) contentMode:UIViewContentModeScaleAspectFill];
                                      image = [image imageByRoundCornerRadius:image.size.width];
                                      return image;
                                  } completion:nil];
        cell.leftImageViewHeightConstraint.constant = 50;
        cell.bottomLabel.text = model.position;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *text;
    if (section == 0) {
        text = [NSString stringWithFormat:@"我的客户有%lu个",[(NSArray *)_tableData[section] count]];
    } else {
        text = [NSString stringWithFormat:@"共享客户有%lu个",[(NSArray *)_tableData[section] count]];
    }
    UILabel *label = [UICreator createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)
                                                text:text
                                       textAlignment:NSTextAlignmentLeft
                                            fontSize:15
                                           textColor:[UIColor zd_secondaryContentColor]
                                             bgColor:[UIColor zd_backgroundColor]];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [_searchVC show];
    
    return NO;
}

- (void)searchVCCancelButtonClicked:(ZDSearchViewController *)searchVC {
    [_searchData removeAllObjects];
    [_searchVC.tableView reloadData];
}

- (void)searchVC:(ZDSearchViewController *)searchVC textDidChange:(NSString *)searchText {
    _searchData = [[ZDCrmManager sharedManager] crmsWithSearchText:searchText].mutableCopy;
    [_searchVC.tableView reloadData];
}

@end

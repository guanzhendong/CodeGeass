//
//  ZDToolViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/3.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDToolViewController.h"
#import "ZDCorpManager.h"
#import "ZDSearchViewController.h"
#import "ZDCorpInfoViewController.h"
#import "ZDQQFriendViewController.h"

@interface ZDToolViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ZDSearchViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) ZDSearchViewController *searchVC;
@property (nonatomic, strong) NSMutableArray *searchData;
@property (nonatomic, copy) NSString *parentId;
@end

@implementation ZDToolViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _parentId = @"0";
    }
    return self;
}

- (instancetype)initWithParentId:(NSString *)parentId {
    self = [super init];
    if (self) {
        _parentId = parentId;
        self.title = [[ZDCorpManager sharedManager] employeeWithId:parentId].name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightButtonWithTitle:@"QQ好友" action:@selector(pushToQQFriendVC)];
    
    [self initData];
    [self initUI];
}

- (void)initData {
//    _tableData = [[ZDCorpManager sharedManager] allEmployees].mutableCopy;
    _tableData = [[ZDCorpManager sharedManager] employeesWithParentId:_parentId].mutableCopy;
}

- (void)initUI {
    CGFloat height = _parentId.integerValue == 0 ? CONTENT_HEIGHT - TABBAR_HEIGHT : CONTENT_HEIGHT;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell3" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell3"];
    [self.view addSubview:_tableView];
    
    
    UISearchBar *bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    bar.placeholder = @"搜索";
    bar.delegate = self;
    _tableView.tableHeaderView = bar;
    bar.backgroundImage = [UIImage new];// 去除掉top、bottom的细线
    bar.backgroundColor = [UIColor zd_backgroundColor];// 这两行顺序不能颠倒
//    [bar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor zd_backgroundColor] size:CGSizeMake(SCREEN_WIDTH - 16, 28)] forState:UIControlStateNormal];
    
    
    _searchVC = [[ZDSearchViewController alloc] initWithParentVC:self];
    _searchVC.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _searchVC.tableView.delegate = self;
    _searchVC.tableView.dataSource = self;
    _searchVC.tableView.rowHeight = 70;
    _searchVC.tableView.backgroundColor = [UIColor zd_backgroundColor];
    _searchVC.placeholder = @"搜索同事名字、职位、手机号";
    _searchVC.tableView.tableFooterView = [UIView new];
    _searchVC.tableView.separatorColor = [UIColor zd_separatorColor];
    [_searchVC.tableView registerNib:[UINib nibWithNibName:@"ZDCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"ZDCommonTableViewCell1Search"];
    [_searchVC.view addSubview:_searchVC.tableView];
}

- (void)pushToQQFriendVC {
    ZDQQFriendViewController *friendVC = [ZDQQFriendViewController new];
    [self.navigationController pushViewController:friendVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return _tableData.count;
    }
    return _searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     * 如果用这种写法（相同的cell复用ID）会导致搜索情形下tableView滑动有卡顿，所以对于normal和search两个状态下使用不同的cell复用ID
     *
     ZDCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1" forIndexPath:indexPath];
     ZDEmployeeModel *employee;
     if (tableView == _tableView) {
     employee = _tableData[indexPath.row];
     } else {
     employee = _searchData[indexPath.row];
     }
     cell.topLabel.text = employee.name;
     [cell.leftImageView setImageWithURL:[NSURL URLWithString:employee.face]
     placeholder:[UIImage zd_middleImageWithText:employee.name]
     options:0
     progress:nil
     transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
     return [image imageByRoundCornerRadius:image.size.width];
     } completion:nil];
     cell.leftImageViewHeightConstraint.constant = 50;
     cell.bottomLabel.text = employee.position;
     return cell;
     */
    if (tableView == _tableView) {
        ZDEmployeeModel *employee = _tableData[indexPath.row];
        if (employee.type == ZDEmployeeTypeUser) {
            ZDCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1" forIndexPath:indexPath];
            cell.topLabel.text = employee.name;
            [cell.leftImageView setImageWithURL:[NSURL URLWithString:employee.face]
                                    placeholder:[UIImage zd_middleImageWithText:employee.name]
                                        options:0
                                       progress:nil
                                      transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                          return [image imageByRoundCornerRadius:image.size.width];
                                      } completion:nil];
            cell.leftImageViewHeightConstraint.constant = 50;
            cell.bottomLabel.text = employee.position;
            return cell;
        } else {
            ZDCommonTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell3" forIndexPath:indexPath];
            cell.leftLabel.text = employee.name;
            cell.leftImageView.image = [UIImage zd_middleImageWithText:employee.name];
            cell.leftImageViewHeightConstraint.constant = 50;
            cell.rightLabel.text = [NSString stringWithFormat:@"%lu",employee.number];
            [cell showRightArrow:YES];
            return cell;
        }
    } else {
        ZDCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDCommonTableViewCell1Search" forIndexPath:indexPath];
        ZDEmployeeModel *employee = _searchData[indexPath.row];
        cell.topLabel.text = employee.name;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:employee.face]
                                placeholder:[UIImage zd_middleImageWithText:employee.name]
                                    options:0
                                   progress:nil
                                  transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                      return [image imageByRoundCornerRadius:image.size.width];
                                  } completion:nil];
        cell.leftImageViewHeightConstraint.constant = 50;
        cell.bottomLabel.text = employee.position;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZDEmployeeModel *model;
    if (tableView == _tableView) {
        model = _tableData[indexPath.row];
    } else {
        model = _searchData[indexPath.row];
    }
    if (model.type == ZDEmployeeTypeCorp) {
        ZDToolViewController *vc = [[ZDToolViewController alloc] initWithParentId:model.Id];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (model.type == ZDEmployeeTypeUser) {
        ZDCorpInfoViewController *infoVC = [[ZDCorpInfoViewController alloc] initWithEmployeeId:model.Id];
        infoVC.showNavigationBarWhenFromSearch = tableView == _searchVC.tableView;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _searchVC.tableView) {
        [_searchVC.view endEditing:YES];
    }
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
    _searchData = [[ZDCorpManager sharedManager] employeesWithSearchText:searchText].mutableCopy;
    [_searchVC.tableView reloadData];
}

@end

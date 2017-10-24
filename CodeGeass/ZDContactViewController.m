//
//  ZDContactViewController.m
//  CodeGeass
//
//  Created by ec on 2017/5/15.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDContactViewController.h"
#import <Contacts/Contacts.h>

@interface ZDContactViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZDSearchViewController *searchVC;
@property (nonatomic, strong) NSMutableDictionary *tableData;// 索引为key，联系人数组为value
@property (nonatomic, strong) NSMutableArray *searchData;
@property (nonatomic, strong) CNContactStore *store;
@property (nonatomic, strong) NSMutableDictionary *images;
@property (nonatomic, strong) NSMutableArray *indexs;// 索引
@end

@implementation ZDContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    
    _tableData = [NSMutableDictionary dictionary];
    _images = [NSMutableDictionary dictionary];
    _indexs = [NSMutableArray array];
    [self checkContactAuthorization];
}

- (void)checkContactAuthorization {
    _store = [CNContactStore new];
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        case CNAuthorizationStatusAuthorized://存在权限
        {
            [self initUI];
            [self fetchRequestContacts];
        }
            break;
        case CNAuthorizationStatusDenied://已拒绝
        {
            ZDALERT(@"温馨提示", @"你已拒绝访问通讯录，请到“设置”-->“隐私”-->“通讯录”中打开权限", @"好的")
        }
            break;
        case CNAuthorizationStatusRestricted://未被授权
        case CNAuthorizationStatusNotDetermined://权限未知
        {
            // 请求权限
            [_store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initUI];
                    });
                    [self fetchRequestContacts];
                } else {
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
            break;
    }
}

- (void)fetchRequestContacts {
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactImageDataKey,CNContactPhoneNumbersKey]];
    [SVProgressHUD showWithStatus:@"获取通讯录..."];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TICK
        NSError *error;
        [_store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            NSString *name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];// 姓氏和名字拼接
            NSString *key = IsValidObject(name) ? [[[name zd_transformToPinyinFirstLetter] substringToIndex:1] lowercaseString] : @"#";
            if (![_indexs containsObject:key]) {
                [_indexs sa_addObject:key];
            }
            if ([_tableData sa_objectForKey:key]) {
                NSMutableArray *array = [_tableData[key] mutableCopy];
                [array addObject:contact];
                [_tableData sa_setObject:array forKey:key];
            } else {
                [_tableData sa_setObject:@[contact] forKey:key];
            }
            
            if (IsValidObject(contact.imageData)) {
                UIImage *image = [[UIImage alloc] initWithData:contact.imageData];
                image = [image imageByResizeToSize:CGSizeMake(150, 150) contentMode:UIViewContentModeScaleAspectFill];
                image = [image imageByRoundCornerRadius:image.size.width];
                [_images setObject:image forKey:contact.identifier];
            }
        }];
        TOCK
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }

        // 升序
        [_indexs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [_tableView reloadData];
        });
    });
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor zd_separatorColor];
    _tableView.sectionIndexColor = [UIColor zd_greenThemeColor];
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"CGCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"CGCommonTableViewCell1"];
    [self.view addSubview:_tableView];
    
    
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
    _searchVC.placeholder = @"搜索联系人名字";
    _searchVC.tableView.tableFooterView = [UIView new];
    _searchVC.tableView.separatorColor = [UIColor zd_separatorColor];
    [_searchVC.tableView registerNib:[UINib nibWithNibName:@"CGCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"CGCommonTableViewCell1Search"];
    [_searchVC.view addSubview:_searchVC.tableView];
}

#pragma mark - UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return _indexs.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        NSString *key = _indexs[section];
        return ((NSArray *)_tableData[key]).count;
    }
    return _searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        CGCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"CGCommonTableViewCell1" forIndexPath:indexPath];
        NSString *key = _indexs[indexPath.section];
        CNContact *contact = _tableData[key][indexPath.row];
        cell.topLabel.text = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        if ([_images sa_objectForKey:contact.identifier]) {
            cell.leftImageView.image = _images[contact.identifier];
        } else {
            cell.leftImageView.image = [UIImage zd_largeImageWithText:cell.topLabel.text];
        }
        cell.leftImageViewHeightConstraint.constant = 50;
        cell.bottomLabel.text = contact.phoneNumbers.firstObject.value.stringValue;
        return cell;
    } else {
        CGCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"CGCommonTableViewCell1Search" forIndexPath:indexPath];
        CNContact *contact = _searchData[indexPath.row];
        cell.topLabel.text = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        if ([_images sa_objectForKey:contact.identifier]) {
            cell.leftImageView.image = _images[contact.identifier];
        } else {
            cell.leftImageView.image = [UIImage zd_largeImageWithText:cell.topLabel.text];
        }
        cell.leftImageViewHeightConstraint.constant = 50;
        cell.bottomLabel.text = contact.phoneNumbers.firstObject.value.stringValue;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return _indexs[section];
    }
    return nil;
}

// 索引的代理方法
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return _indexs;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CNContact *contact;
    if (tableView == _tableView) {
        NSString *key = _indexs[indexPath.section];
        contact = _tableData[key][indexPath.row];
    } else {
        contact = _searchData[indexPath.row];
    }
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",contact.phoneNumbers.firstObject.value.stringValue]];
    if ([[UIApplication sharedApplication] canOpenURL:telURL]) {
//        [[UIApplication sharedApplication] openURL:telURL];
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
    NSError *error;
    _searchData = [_store unifiedContactsMatchingPredicate:[CNContact predicateForContactsMatchingName:searchText] keysToFetch:@[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactImageDataKey,CNContactPhoneNumbersKey] error:&error].mutableCopy;
    [_searchVC.tableView reloadData];
}

@end

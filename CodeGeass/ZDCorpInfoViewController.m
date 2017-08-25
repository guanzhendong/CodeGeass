//
//  ZDCorpInfoViewController.m
//  CodeGeass
//
//  Created by ec on 2017/5/8.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCorpInfoViewController.h"
#import "YYPhotoGroupView.h"
#import "JTSImageViewController.h"

static CGFloat const kNavigationBarShowAtOffsetY = 64;

@interface ZDCorpInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZDEmployeeModel *employee;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation ZDCorpInfoViewController

- (instancetype)initWithEmployeeId:(NSString *)employeeId {
    self = [super init];
    if (self) {
        _employee = [[ZDCorpManager sharedManager] employeeWithId:employeeId];
    }
    return self;
}

- (BOOL)isTranslucentNavBar {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_showNavigationBarWhenFromSearch) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_showNavigationBarWhenFromSearch) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self createRightButtonWithImage:@"navBar_more_white" action:nil];
}

- (void)initUI {
    self.title = @"同事详情";
    self.translucentNavigationBar.backgroundColor = [UIColor flatSkyBlueColor];
    
    _tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor zd_separatorColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"CGCommonTableViewCell1" bundle:nil] forCellReuseIdentifier:@"CGCommonTableViewCell1"];
    [self.view addSubview:_tableView];
    
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _tableView.tableHeaderView = _headerView;
    
    _blurImageView = [[UIImageView alloc] initWithFrame:_headerView.frame];
    [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:_employee.face] options:0 progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (image) {
            image = [image imageByResizeToSize:_blurImageView.frame.size contentMode:UIViewContentModeScaleAspectFill];
            _blurImageView.image = [image imageByBlurRadius:20 tintColor:[[UIColor zd_blackThemeColor] colorWithAlphaComponent:0.3] tintMode:0 saturation:1 maskImage:nil];
        }
    }];
    [_headerView addSubview:_blurImageView];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, 100, 100, 100)];
    [_headImageView setImageURL:[NSURL URLWithString:_employee.face]];
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageViewTapped)];
    [_headImageView addGestureRecognizer:tap];
    [_headerView addSubview:_headImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _headImageView.bottom + 10, SCREEN_WIDTH - 30, 20)];
    nameLabel.text = _employee.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:nameLabel];
    
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, nameLabel.bottom + 10, SCREEN_WIDTH - 30, 20)];
    positionLabel.text = _employee.position;
    positionLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:positionLabel];
}

- (void)headImageViewTapped {
    // 类似微博、微信的点击九宫格图片浏览器
    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
    item.thumbView = _headImageView;
    YYPhotoGroupView *browser = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
    [browser presentFromImageView:_headImageView toContainer:self.navigationController.view animated:YES completion:nil];
    
    // 此方式只能看一张图片，使用面窄一些，效果不错，但是GitHub上不再维护了
//    // Create image info
//    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
//    imageInfo.image = _headImageView.image;
//    imageInfo.referenceRect = _headImageView.frame;
//    imageInfo.referenceView = _headImageView.superview;
//    // Setup view controller
//    JTSImageViewController *imageViewer = [[JTSImageViewController alloc] initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
//    // Present the view controller.
//    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > kNavigationBarShowAtOffsetY) {
        CGFloat alpha = MIN(1, 1 - (kNavigationBarShowAtOffsetY + 64 - offsetY) / 64);
        self.translucentNavigationBar.alpha = alpha;
    } else {
        self.translucentNavigationBar.alpha = 0;
    }
    
    
    if (offsetY < 0) {
        _blurImageView.frame = CGRectMake(_headerView.left + offsetY / 2, _headerView.top + offsetY, _headerView.width - offsetY, _headerView.height - offsetY);
        _headImageView.bounds = CGRectMake(0, 0, 100, 100);
    } else if (offsetY < kNavigationBarShowAtOffsetY) {
        _headImageView.bounds = CGRectMake(0, 0, 100 - offsetY*3/4, 100 - offsetY*3/4);
    } else {
        _headImageView.bounds = CGRectMake(0, 0, 100 - kNavigationBarShowAtOffsetY*3/4, 100 - kNavigationBarShowAtOffsetY*3/4);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGCommonTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"CGCommonTableViewCell1" forIndexPath:indexPath];
    return cell;
}



@end

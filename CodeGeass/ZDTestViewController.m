//
//  ZDTestViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/4.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDTestViewController.h"
#import "UIImage+ZDExtension.h"
#import "MLImagePickerViewController.h"
#import "TZImagePickerController.h"
#import <INTULocationManager.h>
#import "UIImage+ZDCompress.h"
#import <FSCalendar.h>
//#import <ZFPlayerView.h>
#import "TLSpringFlowLayout.h"
#import <Contacts/Contacts.h>
#import <CoreText/CoreText.h>
#import "ZDCalculator.h"
#import "ZDCalculator2.h"
#import <TSMessage.h>

@interface ZDTestViewController ()<UICollectionViewDataSource>

@end

@implementation ZDTestViewController

+ (void)load {

}

+ (void)initialize {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    


    // 测试1：xcode控制台打印包含汉字的字典是否正确
    NSLog(@"测试打印字典里面的汉字：%@",@{@"11":@"我啊",@"hjv":@"单房卡文件费"});
    
    // 测试2：容错处理是否正常
    NSString *s = nil;
    NSArray *array = @[s];
    
    // 测试3：LCActionSheet使用
    [self createRightButtonWithTitle:@"选择图片" action:@selector(testLCActionSheet)];
    
    // 测试4：RKNotificationHub使用
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, 200, 50)];
    view.backgroundColor = [UIColor flatBlueColor];
    [self.view addSubview:view];
    RKNotificationHub *hub = [[RKNotificationHub alloc] initWithView:view];
    [hub increment];
    [hub bump];
    
    // 测试5：根据文字生成图片测试
    [self testImageFromText];
    
    
    // 测试6：block测试
    [self method2:^BOOL(BOOL cat) {
        return YES;
    }];
    
    
    // 测试7：YYWeakProxy使用
    //YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:proxy selector:@selector(timerHandler) userInfo:nil repeats:NO];
    // 此cocoapods的YYTimer有问题
    //YYTimer *yyTimer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timerHandler) repeats:NO];
    //[yyTimer fire];

    
    // 测试8：YYWebImage的transform
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:iv];
//    [iv setImageWithURL:[NSURL URLWithString:@"https:\/\/ec-web.staticec.com\/face\/21299\/cMbD1Y882373.png?x-oss-process=image\/resize,m_lfit,h_150,w_150&1477633373"]
//            placeholder:nil
//                options:YYWebImageOptionRefreshImageCache
//               progress:nil
//              transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
//                  return [image imageByRoundCornerRadius:image.size.width];
//              }
//             completion:nil];
    [iv sd_setImageWithURL:[NSURL URLWithString:@"https:\/\/ec-web.staticec.com\/face\/21299\/cMbD1Y882373.png?x-oss-process=image\/resize,m_lfit,h_150,w_150&1477633373"] cornerRadius:20 placeholderImage:nil options:SDWebImageRefreshCached progress:nil completed:nil];
    
    // 测试9：YYTextView
    YYTextView *tv = [[YYTextView alloc] initWithFrame:CGRectMake(100, 250, 200, 100)];
    tv.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:tv];

    
    // 测试10：定位
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        NSLog(@"定位结果：%@",currentLocation);
    }];
    
    
    // 测试11：textView
//    UITextView *t = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
//    t.alwaysBounceVertical = YES;
//    t.font = [UIFont systemFontOfSize:17];
//    t.placeholder = @"输入心里话";
//    [t zd_setupKeyboardAvoid];
//    [self.view addSubview:t];
    
    
    // 测试12：图片压缩
    /*
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:SCREEN_BOUNDS];
    sc.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*2);
    [self.view addSubview:sc];
    UIImage *imageHD = [UIImage imageNamed:@"imageHD.jpg"];
    UIImageView *iv1 = [[UIImageView alloc] initWithImage:imageHD];
    iv1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*2/3);
    [sc addSubview:iv1];
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*2/3, SCREEN_WIDTH, SCREEN_WIDTH*2/3)];
    [imageHD zd_compressToDataLength:20*1024 block:^(NSData *data) {
        iv2.image = [UIImage imageWithData:data];
    }];
    [sc addSubview:iv2];
    UIImageView *iv3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*4/3, SCREEN_WIDTH, SCREEN_WIDTH*2/3)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageHD zd_tryCompressToDataLength:100*1024 block:^(NSData *data) {
            iv3.image = [UIImage imageWithData:data];
        }];
    });
    [sc addSubview:iv3];
    */
    
    // 测试13：FSCalendar
//    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
//    [self.view addSubview:calendar];
    
    // 测试14：ZFPlayer
//    ZFPlayerView *player = [[ZFPlayerView alloc] init];
//    ZFPlayerModel *model = [ZFPlayerModel new];
//    model.title = @"I love you";
//    model.videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mov"]];
//    UIView *dada = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
//    [self.view addSubview:dada];
//    model.fatherView = dada;
//    [player playerModel:model];
//    [player autoPlayTheVideo];

    
    // 测试14：TLSpringFlowLayout
//    TLSpringFlowLayout *layout = [TLSpringFlowLayout new];
//    layout.scrollResistanceFactor = 700;
//    layout.itemSize = CGSizeMake(120, 120);
//    layout.minimumLineSpacing = 20;
//    layout.minimumInteritemSpacing = 20;
//    UICollectionView *col = [[UICollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];
//    col.dataSource = self;
//    col.backgroundColor = [UIColor zd_backgroundColor];
//    [col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    [self.view addSubview:col];
    
    
    // 测试15：自定义UIAlertController
    [self createRightButtonWithTitle:@"alert" action:@selector(alert)];
    
    
    
    
    
}

- (void)alert {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"发啊奥奥奥奥奥所发奥" preferredStyle:UIAlertControllerStyleAlert];
    [ac zd_setTitleColor:[UIColor flatBlueColor]];
    [ac zd_setMessageColor:[UIColor flatGreenColor]];
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *aa1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *aa2 = [UIAlertAction actionWithTitle:@"稍后" style:UIAlertActionStyleDestructive handler:nil];
    [ac addAction:aa];
    [ac addAction:aa1];
    //    [ac addAction:aa2];
    [ac zd_setActionTitleColor:[UIColor flatRedColor]];
    [self presentViewController:ac animated:YES completion:nil];
    
    [TSMessage showNotificationWithTitle:@"恭喜您，购买成功！" type:TSMessageNotificationTypeSuccess];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor flatPinkColor];
    return cell;
}

- (void)method2:(BOOL (^)(BOOL))blockName {
    if (blockName) {
        BOOL value = blockName(YES);
    }
}

- (void)testLCActionSheet {
    WEAKSELF
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:@"选择方式"
                                       cancelButtonTitle:@"取消"
                                                 clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
                                                     if (buttonIndex == 1) {
                                                         MLImagePickerViewController *vc = [MLImagePickerViewController new];
                                                         [vc displayForVC:self completionHandle:nil];
                                                     } else if (buttonIndex == 2) {
                                                         TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
                                                         [self presentViewController:vc animated:YES completion:nil];
                                                     }
                                                 }
                                       otherButtonTitles:@"ML库",@"TZ库", nil];
    [sheet show];
    
    sheet.didDismissHandler = ^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex){
        STRONGSELF
        [strongSelf.KVOController unobserve:actionSheet];
//        [actionSheet removeObserver:strongSelf forKeyPath:@"frame"];
    };
    
    // 测试FBKVOController，observer observe:owner
    self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:sheet keyPath:@"frame" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change[NSKeyValueChangeNewKey]);
    }];
    
    // 系统KVO写法，owner addObserver:observer，两个对象的位置是和上面相反的
//    [sheet addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

- (void)testImageFromText {
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
    imageView1.image = [UIImage zd_smallImageWithText:@"钰莹"];
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 60, 60)];
    imageView2.image = [UIImage zd_middleImageWithText:@"茜茜"];
    [self.view addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 90, 90)];
    imageView3.image = [UIImage zd_largeImageWithText:@"皑扇"];
    [self.view addSubview:imageView3];
    
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 30, 30)];
    imageView4.image = [UIImage zd_smallImageWithText:@"英"];
    [self.view addSubview:imageView4];
    
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 60, 60)];
    imageView5.image = [UIImage zd_middleImageWithText:@"琪"];
    [self.view addSubview:imageView5];
    
    UIImageView *imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 90, 90)];
    imageView6.image = [UIImage zd_largeImageWithText:@"娲"];
    [self.view addSubview:imageView6];
}

@end

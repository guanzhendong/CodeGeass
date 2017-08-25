//
//  ZDLoginViewController.m
//  CodeGeass
//
//  Created by ec on 2017/1/4.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDLoginViewController.h"
#import "ZDTabBarController.h"
#import "ZDUserManager.h"

@interface ZDLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ZDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor zd_backgroundColor];
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _loginButton.clipsToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    
}

- (IBAction)login:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
        return;
    }
    if (_passwordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    [[ZDUserManager sharedManager] loginWithAccount:_accountTF.text
                                           password:_passwordTF.text
                                            success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval time) {
                                                if (returnCode == 100) {
                                                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                    
                                                    [YYKeychain setPassword:self.passwordTF.text forService:[UIApplication sharedApplication].appBundleName account:self.accountTF.text];
                                                    
                                                    [ZDAppDelegate changeRootViewController:[ZDTabBarController new]];
                                                    
                                                }
                                          } failure:^(NSInteger errorCode, NSString *errorMsg) {
                                              [SVProgressHUD showErrorWithStatus:@"登录失败"];
                                          }];
}

@end

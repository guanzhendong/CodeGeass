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
#import "FCAlertView.h"

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
//    [self requestVerifySMSCode:@"520248"];
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
    [[ZDUserManager sharedManager] loginWithAccount:_accountTF.text password:_passwordTF.text success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval time) {
        if (returnCode == 200) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            [YYKeychain setPassword:self.passwordTF.text forService:[UIApplication sharedApplication].appBundleName account:self.accountTF.text];
            
            [ZDAppDelegate changeRootViewController:[ZDTabBarController new]];
            
        } else if (returnCode == 1010) {
            [SVProgressHUD dismiss];
            FCAlertView *alert = [FCAlertView new];
            alert.titleFont = [UIFont boldSystemFontOfSize:18];
            alert.colorScheme = [UIColor randomFlatColor];
            [alert showAlertWithTitle:returnMsg withSubtitle:nil withCustomImage:nil withDoneButtonTitle:@"好的" andButtons:@[@"取消"]];
            [alert doneActionBlock:^{
                [self requestGetSMSCode];
            }];
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}

- (void)requestGetSMSCode {
    [[ZDUserManager sharedManager] requestSMSCodeWithAccount:_accountTF.text success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp) {
        if (returnCode == 200) {
            FCAlertView *alert = [FCAlertView new];
            alert.titleFont = [UIFont boldSystemFontOfSize:18];
            alert.colorScheme = [UIColor randomFlatColor];
            [alert addTextFieldWithPlaceholder:@"请输入验证码" andTextReturnBlock:^(NSString *text) {
                [self requestVerifySMSCode:text];
            }];
            [alert showAlertWithTitle:returnMsg withSubtitle:nil withCustomImage:nil withDoneButtonTitle:@"好的" andButtons:@[@"取消"]];
            [alert doneActionBlock:^{
//                [self requestVerifySMSCode:alert.textField.text];
            }];
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

- (void)requestVerifySMSCode:(NSString *)code {
    [[ZDUserManager sharedManager] requestVerifySMSCodeWithAccount:@"15220099284" verificationCode:code success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp) {
        if (returnCode == 200) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            [YYKeychain setPassword:self.passwordTF.text forService:[UIApplication sharedApplication].appBundleName account:self.accountTF.text];
            
            [ZDAppDelegate changeRootViewController:[ZDTabBarController new]];
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

@end

//
//  ZDUserModel.h
//  CodeGeass
//
//  Created by ec on 2017/1/10.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDUserAuthModel.h"

@interface ZDUserModel : NSObject

/*
 {
 "ret" : "100",
 "msg" : "登录成功",
 "data" : {
 "uid" : 1947882,
 "f_ssl" : "",
 "f_smtp" : "smtp.exmail.qq.com",
 "f_corpsname" : "六度人和",
 "key" : "\/HsyXQtW\/oaWC5RXVpmlVRGKh7XFqzdISE7rj3n2j6A=",
 "username" : "官振东",
 "f_lost" : 0,
 "f_token" : "f09b4328b35a94260590625da40b9780",
 "f_pwd" : "19930521gzd",
 "f_port" : "25",
 "f_corp_id" : "21299",
 "f_account" : "guanzd@ecqun.com"
 }
 }
 */


/*
 {
 "data" : {
 "remark" : "",
 "mobile" : "15220099284",
 "phone" : "",
 "id" : 2078802,
 "fax" : "",
 "f_face" : "https:\/\/oss-cn-hangzhou.aliyuncs.com\/ec-web-test\/21299\/face\/e5814c19-4370-6175-da77-cb9dec93c076?x-oss-process=image\/resize,m_lfit,h_150,w_150",
 "f_ctime" : 1481700373,
 "email" : "",
 "f_vcode" : "https:\/\/www.workec.com\/default\/form\/vcard?uid=2078802&cid=21299",
 "name" : "官振东"
 },
 "msg" : "获取信息成功",
 "time" : 1484538460,
 "ret" : 100
 }
 */

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *ssl;
@property (nonatomic, copy) NSString *smtp;
@property (nonatomic, copy) NSString *corpName;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lost;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *corpId;
@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *vcode;


@property (nonatomic, strong) ZDUserAuthModel *authModel;


- (void)updateWithDictionary:(NSDictionary *)dic;

@end

//
//  ZDUserModel.m
//  CodeGeass
//
//  Created by ec on 2017/1/10.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDUserModel.h"

@implementation ZDUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"Id"            : @"uid",
             @"ssl"           : @"f_ssl",
             @"smtp"          : @"f_smtp",
             @"corpName"      : @"f_corpsname",
             @"key"           : @"key",
             @"name"          : @"username",
             @"lost"          : @"f_lost",
             @"token"         : @"f_token",
             @"pwd"           : @"f_pwd",
             @"port"          : @"f_port",
             @"corpId"        : @"f_corp_id",
             @"account"       : @"f_account"
             };
}

- (void)updateWithDictionary:(NSDictionary *)dic {
    self.remark = [dic sa_stringForKey:@"remark"];
    self.mobile = [dic sa_stringForKey:@"mobile"];
    self.phone = [dic sa_stringForKey:@"phone"];
    self.fax = [dic sa_stringForKey:@"fax"];
    self.face = [dic sa_stringForKey:@"f_face"];
    self.createTime = [dic sa_stringForKey:@"f_ctime"];
    self.email = [dic sa_stringForKey:@"email"];
    self.vcode = [dic sa_stringForKey:@"f_vcode"];
}

@end

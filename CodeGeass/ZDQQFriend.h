//
//  ZDQQFriend.h
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"

@interface ZDQQFriend : NSObject

/*
 {
 "f_frd_qq_id" : "120",
 "f_face" : "https:\/\/q.qlogo.cn\/qqapp\/101154401\/643512BF18A4712F594E4F9884F209FC\/40",
 "f_group_id" : "2",
 "f_nickname" : "小宝哥(borg)",
 "f_ctime" : "1496636769",
 "f_crm_userid" : "405896",
 "f_crm_id" : "227126319",
 "f_remark" : "肖志勇"
 }
 */

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *crmId;
@property (nonatomic, copy) NSString *crmUserId;
@property (nonatomic, copy) NSString *time;

@end

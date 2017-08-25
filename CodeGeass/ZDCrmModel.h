//
//  ZDCrmModel.h
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"

typedef NS_ENUM(NSUInteger, ZDCrmType) {
    ZDCrmTypeMine, // 我的客户
    ZDCrmTypeShare,// 共享给我的客户
};

@interface ZDCrmModel : NSObject

/*
 {
 "f_tagids" : "401283#80454314#80445507#81799170#80643840#80643839#80643838#80619398#80454322#80445503",
 "f_phone" : "01025512345",
 "f_mobile" : "18688886666",
 "f_type" : "1",
 "f_name" : "哦哦",
 "f_user_id" : "1947882",
 "f_company" : "北京市海淀区新浪科技",
 "f_qq_id" : 0,
 "f_qq" : "",
 "f_friend_id" : "0",
 "f_step" : "0",
 "f_call" : "杨总",
 "f_title" : "开发总监",
 "f_del" : 0,
 "f_classID" : "1947884",
 "f_email" : "100000000@qq.com",
 "f_gender" : "2",
 "f_crm_id" : "360412422",
 "f_face" : "https:\/\/file4crm.oss-cn-hangzhou.aliyuncs.com\/crmaliface\/21299\/360412422.png",
 "f_cs_guid" : "0",
 "f_create_time" : "2016-05-26 19:13:40",
 "f_modify_time" : 1488856993
 }
 */

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, assign) ZDCrmType type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *tagIds;///< 标签id
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *userId;///< 所属人
@property (nonatomic, copy) NSString *qqId;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *friendId;
@property (nonatomic, copy) NSString *step;///< 客户阶段，默认0
@property (nonatomic, copy) NSString *call;///< 称呼
@property (nonatomic, copy) NSString *position;///< 职位
@property (nonatomic, assign) NSInteger del;///< 0正常 1删除（有删除则删除本地 否则更新或者插入到本地）
@property (nonatomic, copy) NSString *classId;///< 分组id
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gender;///< 性别0/1/2，1男、2女
@property (nonatomic, copy) NSString *csGuid;///< 访客id
@property (nonatomic, copy) NSString *createType;///< 创建类型方式
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, assign) NSTimeInterval modifyTime;


@end

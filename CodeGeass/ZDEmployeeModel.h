//
//  ZDEmployeeModel.h
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

//#import "NSObject+BGModel.h"
#import "NSObject+LKDBHelper.h"

typedef NS_ENUM(NSUInteger, ZDEmployeeType) {
    ZDEmployeeTypeUser,// 用户
    ZDEmployeeTypeCorp,// 部门
};

@interface ZDEmployeeModel : NSObject <NSCoding, NSCopying>

/*
 {
 "account" : "18826525254",
 "sort" : "0",
 "f_face" : "https:\/\/ec-web.staticec.com\/face\/0972\/3795972.jpg?x-oss-process=image\/resize,m_lfit,h_150,w_150",
 "id" : "3795972",
 "f_parent_id" : "3861461",
 "f_noshow" : 0,
 "f_ctime" : 1485229010,
 "title" : "实施顾问",
 "del" : 0,
 "type" : "0",
 "name" : "郭水玲"
 }
 */

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *sort;///< 只有是部门的时候才有sort排序,从小到大
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, assign, getter=isHidden) BOOL hidden;
@property (nonatomic, assign) NSInteger updateTime;///< 最后修改时间
@property (nonatomic, copy) NSString *position;
@property (nonatomic, assign) NSInteger del;///< 0/1  1表示需要客户端删除本地数据
@property (nonatomic, assign) ZDEmployeeType type;///< 0用户/1部门
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;///< 手机
@property (nonatomic, copy) NSString *phone;///< 电话
//@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *namePinyin;///< 名字的拼音
@property (nonatomic, copy) NSString *namePinyinFirstLetter;///< 名字的拼音首字母
@property (nonatomic, assign) NSUInteger number;///< 部门人数

@end


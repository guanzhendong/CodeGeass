//
//  ZDGroupModel.h
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"
#import "ZDContactModel.h"

typedef NS_ENUM(NSUInteger, ZDGroupDataType) {
    ZDGroupDataTypeGroup,   // 群
    ZDGroupDataTypeDiscuss, // 讨论组
};

@interface ZDGroupModel : NSObject

/** 群
 {
 "Time" : 1488420136,
 "AD" : "",
 "MemberNames" : [
 "喻影",
 "梁原",
 "官振东",
 "周小林",
 "莫冰",
 "吴楚",
 "耿彭彭"
 ],
 "CreatorID" : 1132839,
 "Nums" : 6,
 "GroupID" : 3813090,
 "Name" : "梁原",
 "GroupName" : "1313",
 "Push" : 2
 }
 */

/** 组
 {
 "lastModiTime" : 1488782233,
 "discussId" : 504172,
 "lspush" : 2,
 "members" : [
 "梁原",
 "官振东",
 "吴楚",
 "耿彭彭"
 ],
 "theme" : "梁原、耿彭彭、官振东、吴楚",
 "nums" : 4
 }
 */

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) ZDGroupDataType type;
@property (nonatomic, copy) NSString *creatorId;
@property (nonatomic, copy) NSString *creatorName;
@property (nonatomic, assign) NSUInteger number;
@property (nonatomic, assign) NSInteger push;///< 推送(0 1 no push)/(2 push)
@property (nonatomic, copy) NSString *announcement;///< 公告
@property (nonatomic, copy) NSArray *memberNames;
@property (nonatomic, strong) NSMutableArray<ZDContactModel *> *members;
@property (nonatomic, assign) NSTimeInterval time;///< 最后修改时间

@end

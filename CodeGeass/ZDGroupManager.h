//
//  ZDGroupManager.h
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDGroupModel.h"

@interface ZDGroupManager : NSObject

SINGLETON_INTERFACE(Manager)

/**
 *  拉取群基本信息(一次全量拉取)
 */
- (void)requestBatchGroupBasicInfoWithBatch:(NSInteger)batch
                                    success:(HttpRequestSuccessBlock)success
                                    failure:(HttpRequestFailureBlock)failure;

/**
 *  拉取讨论组基本信息(批次，根据时间排序)
 */
- (void)requestBatchDiscussionGroupBasicInfoWithBatch:(NSInteger)batch
                                              success:(HttpRequestSuccessBlock)success
                                              failure:(HttpRequestFailureBlock)failure;

/**
 *  群成员列表
 */
- (void)requestGroupMemberListWithGroupId:(NSString *)groupId
                                timestamp:(NSInteger)timestamp
                                  success:(HttpRequestSuccessBlock)success
                                  failure:(HttpRequestFailureBlock)failure;
/**
 *  讨论组成员列表
 */
- (void)requestDiscussMemberListWithGroupId:(NSString *)groupId
                                  timestamp:(NSInteger)timestamp
                                    success:(HttpRequestSuccessBlock)success
                                    failure:(HttpRequestFailureBlock)failure;

- (void)requestAllGroups;

- (ZDGroupModel *)groupWithId:(NSString *)Id
                        type:(ZDGroupDataType)type;

- (NSArray *)allGroups;

@end

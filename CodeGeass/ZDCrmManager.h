//
//  ZDCrmManager.h
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDCrmModel.h"

@interface ZDCrmManager : NSObject

SINGLETON_INTERFACE(Manager)

- (YTKRequest *)requestCrmListWithType:(NSInteger)type
                            startIndex:(NSInteger)startIndex
                                  time:(NSTimeInterval)time
                               success:(void(^)(ZDHTTPResponse *model))success
                               failure:(HttpRequestFailureBlock)failure;

- (void)requestAllCrms;

- (ZDCrmModel *)crmWithId:(NSString *)Id;

- (NSArray *)allCrms;

- (NSArray *)allMineCrms;

- (NSArray *)allShareCrms;

/**
 根据搜索关键字获取客户数组

 @param text text
 @return array
 */
- (NSArray *)crmsWithSearchText:(NSString *)text;

@end

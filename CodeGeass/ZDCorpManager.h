//
//  ZDCorpManager.h
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDEmployeeModel.h"

@interface ZDCorpManager : NSObject

SINGLETON_INTERFACE(Manager)

- (void)requestAllCorps;

/**
 取同事、部门

 @param Id Id
 @return model
 */
- (ZDEmployeeModel *)employeeWithId:(NSString *)Id;

- (NSArray *)allEmployees;

/**
 根据部门Id获取此部门下的人员和子部门

 @param parentId 部门Id
 @return array
 */
- (NSArray<ZDEmployeeModel *> *)employeesWithParentId:(NSString *)parentId;

/**
 根据搜索关键字获取同事

 @param text text
 @return array
 */
- (NSArray<ZDEmployeeModel *> *)employeesWithSearchText:(NSString *)text;

@end

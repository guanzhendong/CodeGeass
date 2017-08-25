//
//  ZDCorpManager.m
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCorpManager.h"
#import "ZDCorpListApi.h"
#import "ZDEmployeeModel.h"

@interface ZDCorpManager ()

@end

@implementation ZDCorpManager

SINGLETON_IMPLEMENTATION(Manager)

- (void)corpListWithStartIndex:(NSInteger)startIndex
                     timestamp:(NSInteger)timestamp
                       success:(void(^)(ZDHTTPResponse *model))success
                       failure:(HttpRequestFailureBlock)failure
{
    ZDCorpListApi *api = [[ZDCorpListApi alloc] initWithStartIndex:startIndex timestamp:timestamp];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (success) {
            success(model);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
}

- (void)requestCorpListWithStartIndex:(NSInteger)startIndex
                            timestamp:(NSInteger)timestamp
                              success:(void(^)())success
                              failure:(void(^)())failure
{
    [self corpListWithStartIndex:startIndex timestamp:timestamp success:^(ZDHTTPResponse *model) {
        if (model.ret == 100) {
            // 拉取到变更，更新时间戳
            if (model.total > 0) {
                [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCorp];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDEmployeeModel *employee = [ZDEmployeeModel modelWithDictionary:dic];
                // 初始化数据时以account字段作为手机
                employee.mobile = [employee.account copy];
                employee.namePinyin = [employee.name zd_transformToPinyin];
                employee.namePinyinFirstLetter = [employee.name zd_transformToPinyinFirstLetter];
                [array addObject:employee];
            }
            [ZDEmployeeModel insertArrayByAsyncToDB:array];
            
            
            
            BOOL finish = model.total == 0 || model.total < model.per;
            
            if (finish) {
                if (success) success();
            } else {
                [self requestCorpListWithStartIndex:model.per + startIndex
                                          timestamp:timestamp
                                            success:success
                                            failure:failure];
            }
        }else if (model.ret == 101) {
            // 无数据变更
            [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCorp];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (success) success();
        }else if (model.ret == 102) {
            //102错误码处理机制：本地数据已经太久了，需要全量拉取了！
            //1.时间戳清零
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kZDTimestampCorp];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //2.数据库清零
            [ZDEmployeeModel deleteWithWhere:nil];
            //3.重新全量拉取
            [self requestCorpListWithStartIndex:0
                                      timestamp:0
                                        success:success
                                        failure:failure];
        }else {
            if (failure) failure();
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        if (failure) failure();
    }];
}

- (void)requestAllCorps {
    NSInteger timestamp = [[NSUserDefaults standardUserDefaults] integerForKey:kZDTimestampCorp];
    [self requestCorpListWithStartIndex:0 timestamp:timestamp success:^{
        // 处理del=1的同事
        [ZDEmployeeModel deleteWithWhere:@{@"del" : @1}];
        // 计算每个部门的人数并更新数据库
        [self numberOfPeopleForCorpWithId:@"0"];
    } failure:nil];
}

- (ZDEmployeeModel *)employeeWithId:(NSString *)Id {
    return (ZDEmployeeModel *)[ZDEmployeeModel searchSingleWithWhere:@{@"Id":Id} orderBy:nil];
}

- (NSArray *)allEmployees {
    return [ZDEmployeeModel searchWithWhere:nil];
}

- (NSArray<ZDEmployeeModel *> *)employeesWithParentId:(NSString *)parentId {
    NSArray *array = [ZDEmployeeModel searchWithWhere:@{@"parentId" : parentId}];
    NSMutableArray *users = [NSMutableArray array];
    NSMutableArray *corps = [NSMutableArray array];
    for (ZDEmployeeModel *model in array) {
        if (model.type == ZDEmployeeTypeUser) {
            [users addObject:model];
        } else if (model.type == ZDEmployeeTypeCorp) {
            if (model.number > 0) {
                [corps addObject:model];
            }
        }
    }
    // 同事根据Id排序，升序
    [users sortUsingComparator:^NSComparisonResult(ZDEmployeeModel * _Nonnull obj1, ZDEmployeeModel * _Nonnull obj2) {
        return [obj1.Id compare:obj2.Id];
    }];
    // 部门根据sort排序，升序
    [corps sortUsingComparator:^NSComparisonResult(ZDEmployeeModel * _Nonnull obj1, ZDEmployeeModel * _Nonnull obj2) {
        return [obj1.sort compare:obj2.sort];
    }];
    // 同事在部门前面
    NSMutableArray *sortedArray = users.mutableCopy;
    [sortedArray addObjectsFromArray:corps];
    return sortedArray;
}

- (NSArray<ZDEmployeeModel *> *)employeesWithSearchText:(NSString *)text {
    if (IsEmptyObject(text)) {
        return nil;
    }
    TICK
    NSArray *array = [ZDEmployeeModel searchWithSQL:[NSString stringWithFormat:@"select * from %@ where type = 0 and (name like '%%%@%%' or position like '%%%@%%' or mobile like '%%%@%%' or namePinyin like '%%%@%%' or namePinyinFirstLetter like '%%%@%%') ",[ZDEmployeeModel getTableName],text,text,text,text,text]];// SQL语句表示name、position、mobile、namePinyin、namePinyinFirstLetter字段包含搜索关键字，%是SQL通配符
    TOCK
    return array;
}


/**
 计算部门内有多少员工

 @param corpId 部门ID
 @return 人数
 */
- (NSUInteger)numberOfPeopleForCorpWithId:(NSString *)corpId {
    NSUInteger count = 0;
    NSArray *array = [ZDEmployeeModel searchWithWhere:@{@"parentId" : corpId}];
    for (ZDEmployeeModel *model in array) {
        if (model.type == ZDEmployeeTypeUser) {
            count++;
        } else if (model.type == ZDEmployeeTypeCorp) {
            count += [self numberOfPeopleForCorpWithId:model.Id];
        }
    }
    if (corpId.integerValue > 0) {
        ZDEmployeeModel *currentCorp = [self employeeWithId:corpId];
        currentCorp.number = count;
        [currentCorp updateToDB];
    }
    return count;
}


@end

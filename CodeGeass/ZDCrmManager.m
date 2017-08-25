//
//  ZDCrmManager.m
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDCrmManager.h"
#import "ZDCrmTotalNumberApi.h"
#import "ZDCrmListApi.h"

@implementation ZDCrmManager

SINGLETON_IMPLEMENTATION(Manager)

- (YTKRequest *)requestCrmTotalNumberWithType:(NSInteger)type
                                   completion:(void (^)(BOOL success, NSInteger total))completion;
{
    ZDCrmTotalNumberApi *api = [[ZDCrmTotalNumberApi alloc] initWithType:type];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            if (completion) {
                completion(YES, model.total);
            }
        } else {
            if (completion) {
                completion(NO, 0);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(NO, 0);
        }
    }];
    return api;
}

- (YTKRequest *)requestCrmListWithType:(NSInteger)type
                            startIndex:(NSInteger)startIndex
                                  time:(NSTimeInterval)time
                               success:(void(^)(ZDHTTPResponse *model))success
                               failure:(HttpRequestFailureBlock)failure
{
    ZDCrmListApi *api = [[ZDCrmListApi alloc] initWithType:type startIndex:startIndex time:time];
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
    return api;
}

- (void)requestCrmWithLine:(NSInteger)line startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex group:(dispatch_group_t)group {
    NSLog(@"line:%ld-----------------------start:%ld-----------------------end:%ld",line,startIndex,endIndex);
    [self requestCrmListWithType:0 startIndex:startIndex time:0 success:^(ZDHTTPResponse *model) {
        if (model.ret == 100) {
            if (startIndex == 0) {
                [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCrm];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)model.data) {
                ZDCrmModel *model = [ZDCrmModel modelWithDictionary:dic];
                if (model.del == 0) {
                    model.type = ZDCrmTypeMine;
                    [array addObject:model];
                } else {
                    [model deleteToDB];
                }
            }
            [ZDCrmModel insertArrayByAsyncToDB:array];
            
            if (model.total > 0 && model.total >= model.per && startIndex + model.per < endIndex) {
                [self requestCrmWithLine:line startIndex:startIndex + model.per endIndex:endIndex group:group];
            } else {
                dispatch_group_leave(group);
            }
        } else {
            dispatch_group_leave(group);
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        dispatch_group_leave(group);
    }];
}

- (void)requestAllCrms {
    NSInteger timestamp = [[NSUserDefaults standardUserDefaults] integerForKey:kZDTimestampCrm];
    if (timestamp == 0) {// 全量拉取
        [self requestCrmTotalNumberWithType:0 completion:^(BOOL success, NSInteger total) {
            if (success) {
                NSUInteger requestLineCount = 1;
                if (total <= 1000) {
                    
                } else if (total <= 15000) {// 客户总数大于1000小于15000时，使用3条请求线
                    requestLineCount = 3;
                } else {                    // 客户总数大于15000时，使用5条请求线
                    requestLineCount = 5;
                }
                // 计算有几千的客户并且向上取整，例如57761则等于58
                NSInteger countOfThousand = ceilf((float)total / 1000);
                // 计算每条请求线需获取的客户数，countOfThousand=58时数值为12000
                NSInteger crmCountNeedRequestEachLine = ceilf((float)countOfThousand / requestLineCount) * 1000;
                dispatch_group_t group = dispatch_group_create();
                NSDate *startTime = [NSDate date];
                for (int i = 0; i < requestLineCount; i++) {
                    dispatch_group_enter(group);
                    [self requestCrmWithLine:i
                                  startIndex:i * crmCountNeedRequestEachLine
                                    endIndex:(i + 1) * crmCountNeedRequestEachLine
                                       group:group];
                }
                dispatch_group_notify(group,dispatch_get_main_queue(),^{
                    NSLog(@"客户数据下载完成，共耗时：%lf秒",- startTime.timeIntervalSinceNow);
                });
            }
        }];
    } else if (timestamp > 0) {// 拉取变更
        [self requestCrmListWithType:0 startIndex:0 time:timestamp success:^(ZDHTTPResponse *model) {
            if (model.ret == 100) {
                // 拉取到变更，更新时间戳
                if (model.total > 0) {
                    [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCrm];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dic in (NSArray *)model.data) {
                    ZDCrmModel *model = [ZDCrmModel modelWithDictionary:dic];
                    if (model.del == 0) {
                        model.type = ZDCrmTypeMine;
                        [array addObject:model];
                    } else {
                        [model deleteToDB];
                    }
                }
                [ZDCrmModel insertArrayByAsyncToDB:array];
            } else if (model.ret == 101) {
                // 无数据变更
                [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCrm];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        } failure:^(NSInteger errorCode, NSString *errorMsg) {
            
        }];
    }
    
    
    // 共享客户
    NSInteger timestampShare = [[NSUserDefaults standardUserDefaults] integerForKey:kZDTimestampCrmShare];
    [self requestCrmListWithType:ZDCrmTypeShare startIndex:0 time:timestampShare success:^(ZDHTTPResponse *model) {
        if (model.ret == 100) {
            // 拉取到变更，更新时间戳
            if (model.total > 0) {
                [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCrmShare];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)model.data) {
                ZDCrmModel *model = [ZDCrmModel modelWithDictionary:dic];
                if (model.del == 0) {
                    model.type = ZDCrmTypeShare;
                    [array addObject:model];
                } else {
                    [model deleteToDB];
                }
            }
            [ZDCrmModel insertArrayByAsyncToDB:array];
        } else if (model.ret == 101) {
            // 无数据变更
            [[NSUserDefaults standardUserDefaults] setInteger:model.time forKey:kZDTimestampCrmShare];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
    
    // 处理del=1的客户
    [ZDCrmModel deleteWithWhere:@{@"del" : @1}];
}

- (ZDCrmModel *)crmWithId:(NSString *)Id {
    return (ZDCrmModel *)[ZDCrmModel searchSingleWithWhere:@{@"Id":Id} orderBy:nil];
}

- (NSArray *)allCrms {
    return [ZDCrmModel searchWithWhere:nil];
}

- (NSArray *)allMineCrms {
    return [ZDCrmModel searchWithWhere:@{@"type" : @(ZDCrmTypeMine)}];
}

- (NSArray *)allShareCrms {
    return [ZDCrmModel searchWithWhere:@{@"type" : @(ZDCrmTypeShare)}];
}

- (NSArray *)crmsWithSearchText:(NSString *)text {
    if (IsEmptyObject(text)) {
        return nil;
    }
    TICK
    NSArray *array = [ZDCrmModel searchWithSQL:[NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' or position like '%%%@%%' or mobile like '%%%@%%' ",[ZDCrmModel getTableName],text,text,text]];// SQL语句表示name、position、mobile字段包含搜索关键字，%是SQL通配符
    TOCK
    return array;
}

@end

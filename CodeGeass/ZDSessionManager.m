//
//  ZDSessionManager.m
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDSessionManager.h"
#import "ZDSessionListApi.h"
#import "ZDGroupIconDownloader.h"

@implementation ZDSessionManager

SINGLETON_IMPLEMENTATION(Manager)

- (YTKRequest *)sessionListWithTimestamp:(NSInteger)timestamp
                                 success:(HttpRequestSuccessBlock)success
                                 failure:(HttpRequestFailureBlock)failure
{
    ZDSessionListApi *api = [[ZDSessionListApi alloc] initWithTimestamp:timestamp];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseObject];
        if (model.ret == 0) {
            if ([(NSArray *)model.data count] > 0) {
                NSDictionary *dic = model.data[0];
                [[NSUserDefaults standardUserDefaults] setInteger:[dic sa_integerForKey:@"Time"] forKey:kZDTimestampSession];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDSessionModel *session = [ZDSessionModel modelWithDictionary:dic];
                [array addObject:session];
            }
            [ZDSessionModel insertArrayByAsyncToDB:array];
        } else if (model.ret == 10) {
            // 无数据变更
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    0);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}

- (void)requestAllSessions {
    NSInteger timestamp = [[NSUserDefaults standardUserDefaults] integerForKey:kZDTimestampSession];
    [self sessionListWithTimestamp:timestamp success:nil failure:nil];
}

- (ZDSessionModel *)sessionWithId:(NSString *)Id
                             type:(ZDSessionDataType)type
{
    return (ZDSessionModel *)[ZDSessionModel searchSingleWithWhere:@{
                                                                     @"Id" : Id,
                                                                     @"type" : @(type)
                                                                     }
                                                           orderBy:nil];
}

- (NSArray *)allSessions {
    NSMutableArray *array = [ZDSessionModel searchWithWhere:nil].mutableCopy;
    // 根据time降序
    [array sortUsingComparator:^NSComparisonResult(ZDSessionModel * _Nonnull obj1, ZDSessionModel * _Nonnull obj2) {
        return -[@(obj1.time) compare:@(obj2.time)];
    }];
    for (ZDSessionModel *model in array) {
        if (model.type == ZDSessionDataTypeGroup
            || model.type == ZDSessionDataTypeDiscuss) {
            model.downloader = [ZDGroupIconDownloader new];
        }
    }
    return array;
}

@end

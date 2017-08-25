//
//  ZDGroupManager.m
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDGroupManager.h"
#import "BatchGroupBasicInfoApi.h"
#import "BatchDiscussionGroupBasicInfoApi.h"
#import "GroupMemberListApi.h"
#import "DiscussionGroupMemberListApi.h"

@implementation ZDGroupManager

SINGLETON_IMPLEMENTATION(Manager)


- (void)requestBatchGroupBasicInfoWithBatch:(NSInteger)batch
                                    success:(HttpRequestSuccessBlock)success
                                    failure:(HttpRequestFailureBlock)failure;
{
    BatchGroupBasicInfoApi *api = [[BatchGroupBasicInfoApi alloc] initWithBatch:batch];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseJSONObject];
        if (model.ret == 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDGroupModel *group = [ZDGroupModel modelWithDictionary:dic];
                group.type = ZDGroupDataTypeGroup;
                [array addObject:group];
            }
            [ZDGroupModel insertArrayByAsyncToDB:array];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    0);
        }
    } failure:^(YTKBaseRequest *request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
}

- (void)requestBatchDiscussionGroupBasicInfoWithBatch:(NSInteger)batch
                                              success:(HttpRequestSuccessBlock)success
                                              failure:(HttpRequestFailureBlock)failure;
{
    BatchDiscussionGroupBasicInfoApi *api = [[BatchDiscussionGroupBasicInfoApi alloc] initWithBatch:batch];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseJSONObject];
        if (model.ret == 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDGroupModel *discuss = [ZDGroupModel modelWithDictionary:dic];
                discuss.type = ZDGroupDataTypeDiscuss;
                
                [array addObject:discuss];
            }
            [ZDGroupModel insertArrayByAsyncToDB:array];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    0);
        }
    } failure:^(YTKBaseRequest *request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
}

- (void)requestGroupMemberListWithGroupId:(NSString *)groupId
                                timestamp:(NSInteger)timestamp
                                  success:(HttpRequestSuccessBlock)success
                                  failure:(HttpRequestFailureBlock)failure
{
    GroupMemberListApi *api = [[GroupMemberListApi alloc] initWithGroupId:groupId timestamp:timestamp];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseJSONObject];
        if (model.ret == 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDContactModel *group = [ZDContactModel modelWithDictionary:dic];
                [array addObject:group];
            }
            ZDGroupModel *group = [self groupWithId:groupId type:ZDGroupDataTypeGroup];
            group.members = array;
            [group updateToDB];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    0);
        }
    } failure:^(YTKBaseRequest *request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
}

- (void)requestDiscussMemberListWithGroupId:(NSString *)groupId
                                  timestamp:(NSInteger)timestamp
                                    success:(HttpRequestSuccessBlock)success
                                    failure:(HttpRequestFailureBlock)failure
{
    DiscussionGroupMemberListApi *api = [[DiscussionGroupMemberListApi alloc] initWithDiscussionGroupId:groupId timestamp:timestamp];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        ZDHTTPResponse2 *model = [ZDHTTPResponse2 modelWithDictionary:request.responseJSONObject];
        if (model.ret == 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in model.data) {
                ZDContactModel *group = [ZDContactModel modelWithDictionary:dic];
                [array addObject:group];
            }
            ZDGroupModel *group = [self groupWithId:groupId type:ZDGroupDataTypeDiscuss];
            group.members = array;
            [group updateToDB];
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    0);
        }
    } failure:^(YTKBaseRequest *request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
}

// 开始只拉取五个批次的讨论组共100个
- (void)requestDiscussInfoTopFive {
    static NSUInteger batch = 0;
    @weakify(self);
    [self requestBatchDiscussionGroupBasicInfoWithBatch:batch success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp) {
        if (returnCode == 0) {
            @strongify(self);
            batch++;
            if (batch < 5 && ((NSArray *)data).count == 20) {
                [self requestDiscussInfoTopFive];
            }
        }
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

- (void)requestAllGroups {
    // 群是一次全量拉取
    [self requestBatchGroupBasicInfoWithBatch:0 success:nil failure:nil];
    // 讨论组第一次拉取一百个
    [self requestDiscussInfoTopFive];
}


- (ZDGroupModel *)groupWithId:(NSString *)Id
                         type:(ZDGroupDataType)type;
{
    return (ZDGroupModel *)[ZDGroupModel searchSingleWithWhere:@{
                                                                 @"Id" : Id,
                                                                 @"type" : @(type)
                                                                 }
                                                       orderBy:nil];
}

- (NSArray *)allGroups {
    return [ZDGroupModel searchWithWhere:nil];
}


@end

//
//  ZDQQFriendManager.m
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDQQFriendManager.h"
#import "ZDQQFriendApi.h"
#import "ZDQQFriendGroupApi.h"

@implementation ZDQQFriendManager

SINGLETON_IMPLEMENTATION(Manager)

- (YTKRequest *)requestQQFriendGroupWithSuccess:(HttpRequestSuccessBlock)success
                                        failure:(HttpRequestFailureBlock)failure
{
    ZDQQFriendGroupApi *api = [ZDQQFriendGroupApi new];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            for (NSDictionary *dic in (NSArray *)model.data) {
                ZDQQFriendGroup *group = [ZDQQFriendGroup modelWithDictionary:dic];
                [ZDQQFriendGroup insertToDB:group];
            }
        }
        if (success) {
            success(model.ret,
                    model.msg,
                    model.data,
                    model.time);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}

- (YTKRequest *)requestQQFriendWithPage:(NSInteger)page
                                success:(HttpRequestSuccessBlock)success
                                failure:(HttpRequestFailureBlock)failure
{
    ZDQQFriendApi *api = [[ZDQQFriendApi alloc] initWithPage:page];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZDHTTPResponse *model = [ZDHTTPResponse modelWithDictionary:request.responseObject];
        if (model.ret == 100) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)model.data) {
                ZDQQFriend *friend = [ZDQQFriend modelWithDictionary:dic];
                [array sa_addObject:friend];
            }
            [ZDQQFriend insertArrayByAsyncToDB:array];
            
            if (model.next > 0) {
                [self requestQQFriendWithPage:page+1 success:success failure:failure];
            } else {
                if (success) {
                    success(model.ret,
                            model.msg,
                            model.data,
                            model.time);
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error.code,
                    request.error.localizedDescription);
        }
    }];
    return api;
}

- (NSArray<ZDQQFriendGroup *> *)allQQFriendGroups {
    return [ZDQQFriendGroup searchWithWhere:nil];
}

- (NSArray<ZDQQFriend *> *)QQFriendsWithGroupId:(NSString *)groupId {
    return [ZDQQFriend searchWithWhere:@{@"groupId" : groupId}];
}

@end

//
//  ZDQQFriendManager.h
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDQQFriend.h"
#import "ZDQQFriendGroup.h"

@interface ZDQQFriendManager : NSObject

SINGLETON_INTERFACE(Manager)

- (YTKRequest *)requestQQFriendGroupWithSuccess:(HttpRequestSuccessBlock)success
                                        failure:(HttpRequestFailureBlock)failure;

- (YTKRequest *)requestQQFriendWithPage:(NSInteger)page
                                success:(HttpRequestSuccessBlock)success
                                failure:(HttpRequestFailureBlock)failure;

- (NSArray<ZDQQFriendGroup *> *)allQQFriendGroups;

- (NSArray<ZDQQFriend *> *)QQFriendsWithGroupId:(NSString *)groupId;

@end

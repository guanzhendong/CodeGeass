//
//  ZDSessionManager.h
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDSessionModel.h"

@interface ZDSessionManager : NSObject

SINGLETON_INTERFACE(Manager)

- (YTKRequest *)sessionListWithTimestamp:(NSInteger)timestamp
                                 success:(HttpRequestSuccessBlock)success
                                 failure:(HttpRequestFailureBlock)failure;

- (void)requestAllSessions;

- (ZDSessionModel *)sessionWithId:(NSString *)Id
                             type:(ZDSessionDataType)type;

- (NSArray *)allSessions;

@end

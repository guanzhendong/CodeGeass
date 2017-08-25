//
//  DiscussionGroupMemberListApi.h
//  ECLite
//
//  Created by ec on 16/6/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "YTKRequest.h"

@interface DiscussionGroupMemberListApi : YTKRequest
- (instancetype)initWithDiscussionGroupId:(NSString *)discussionGroupId
                                timestamp:(NSInteger)timestamp;
@end

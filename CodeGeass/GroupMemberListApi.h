//
//  GroupMemberListApi.h
//  ECLite
//
//  Created by ec on 16/6/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "YTKRequest.h"

@interface GroupMemberListApi : YTKRequest
- (instancetype)initWithGroupId:(NSString *)groupId
                      timestamp:(NSInteger)timestamp;
@end

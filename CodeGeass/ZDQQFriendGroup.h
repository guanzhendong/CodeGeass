//
//  ZDQQFriendGroup.h
//  CodeGeass
//
//  Created by ec on 2017/6/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"

@class ZDQQFriend;

@interface ZDQQFriendGroup : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter=isExpanded) BOOL expanded;///< 是否展开
@property (nonatomic, strong) NSArray<ZDQQFriend *> *friends;

@end

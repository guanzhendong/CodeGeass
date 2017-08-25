//
//  ZDSessionModel.h
//  CodeGeass
//
//  Created by ec on 2017/3/29.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"
#import "ZDGroupIconDownloader.h"

typedef NS_ENUM(NSUInteger, ZDSessionDataType) {
    /** 单聊 */
    ZDSessionDataTypeSingle = 3,
    /** 群聊 */
    ZDSessionDataTypeDiscuss = 4,
    /** 讨论组聊 */
    ZDSessionDataTypeGroup = 5,
};

@interface ZDSessionModel : NSObject

/**
 {
 "MsgId" : "3",
 "TalkID" : 2195495,
 "Time" : 1490175372,
 "Num" : 0,
 "Content" : "666",
 "Type" : 4,
 "ID" : 505159
 }
 */

@property (nonatomic, copy)   NSString *msgId;///< 最后一条消息的msgid
@property (nonatomic, copy)   NSString *talkId;///< 最后一次发话人id
@property (nonatomic, assign) NSTimeInterval time;///< 最后会话时间
@property (nonatomic, assign) NSInteger number;///< 未读条数
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, assign) ZDSessionDataType type;///< 会话类型 3单聊 4讨论组 5群
@property (nonatomic, copy)   NSString *Id;///< 群/组 id
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) ZDGroupIconDownloader *downloader;

@end

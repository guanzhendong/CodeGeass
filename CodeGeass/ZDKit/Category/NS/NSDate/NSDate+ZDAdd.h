//
//  NSDate+ZDAdd.h
//  CodeGeass
//
//  Created by ec on 2017/4/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

// 本类提供一些常用的格式化时间字符串

#import <Foundation/Foundation.h>

@interface NSDate (ZDAdd)

/**
 格式化字符串：yyyy-MM-dd
 */
- (NSString *)zd_stringWithFormat_yMd;
- (NSString *)zd_stringWithFormat_yMdH;
- (NSString *)zd_stringWithFormat_yMdHm;
- (NSString *)zd_stringWithFormat_yMdHms;


/**
 标准时间->中国时间
 */
- (NSDate *)zd_ChinaDate;

/**
 当前中国时间
 */
+ (NSDate *)zd_ChinaDateNow;

/**
 标准时间->手机系统时间
 */
- (NSDate *)zd_systemDate;


/**
 QQ会话列表时间格式
 例如  今天显示：13:23(区分12或24小时制)
      昨天显示：昨天
      七天内显示：星期几
      超过七天显示：04-29
      超过今年显示：2015-12-10

 @return string
 */
- (NSString *)sessionDateFormatStringLikeQQ;

/**
 微信会话列表时间格式
 例如  今天显示：13:23(区分12或24小时制)
      昨天显示：昨天
      七天内显示：星期几
      超过七天显示：15/5/5

 @return string
 */
- (NSString *)sessionDateFormatStringLikeWeChat;

@end

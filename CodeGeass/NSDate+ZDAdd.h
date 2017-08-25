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

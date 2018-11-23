//
//  ZDHTTPResponse2.h
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDHTTPResponse2 : NSObject

/*
 返回码	含义说明
 0	成功
 1	数据库访问失败
 2	客户端json格式有误（参数拼写错误或者类型错误）
 3	讨论组不存在
 4	群不存在
 5	没有管理员权限(群)
 6	SessionId错误
 7	不在群/讨论组里面
 8	数据库操作失败
 9	没有微信权限
 10	数据库没有数据
 */

@property (nonatomic, assign) NSInteger ret;///< 返回码
@property (nonatomic, copy)   NSString *msg;///< 信息
@property (nonatomic, assign) NSInteger time;///< 时间戳
@property (nonatomic, assign) id data;///< 数据

@end

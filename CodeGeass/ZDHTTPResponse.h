//
//  ZDHTTPResponse.h
//  CodeGeass
//
//  Created by ec on 2017/1/19.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDHTTPResponse : NSObject

@property (nonatomic, assign) NSInteger ret;///< 返回码
@property (nonatomic, copy)   NSString *msg;///< 信息
@property (nonatomic, assign) NSTimeInterval time;///< 时间戳
@property (nonatomic, assign) NSInteger per;///< 每页多少个
@property (nonatomic, assign) NSInteger total;///< 本次返回多少个
@property (nonatomic, assign) NSInteger next;///< =0则没有下一页，>0相反
@property (nonatomic, assign) id data;///< 数据

@end

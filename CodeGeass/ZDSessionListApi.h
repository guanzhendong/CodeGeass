//
//  ZDSessionListApi.h
//  CodeGeass
//
//  Created by ec on 2017/1/23.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "YTKRequest.h"

@interface ZDSessionListApi : YTKRequest

- (instancetype)initWithTimestamp:(NSInteger)timestamp;

@end

//
//  ZDCrmListApi.h
//  CodeGeass
//
//  Created by ec on 2017/4/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "YTKRequest.h"

@interface ZDCrmListApi : YTKRequest

- (instancetype)initWithType:(NSInteger)type
                  startIndex:(NSInteger)startIndex
                        time:(NSTimeInterval)time;
    
@end

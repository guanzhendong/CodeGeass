//
//  ZDCorpListApi.h
//  CodeGeass
//
//  Created by ec on 2017/1/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "YTKRequest.h"

@interface ZDCorpListApi : YTKRequest

- (instancetype)initWithStartIndex:(NSInteger)startIndex
                         timestamp:(NSInteger)timestamp;

@end

//
//  ZDLoginApi.h
//  CodeGeass
//
//  Created by ec on 2017/1/6.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "YTKRequest.h"

@interface ZDLoginApi : YTKRequest

- (instancetype)initWithAccount:(NSString *)account
                            key:(NSString *)key
                          token:(NSString *)token
                      loginType:(NSInteger)loginType
                         lsPush:(NSInteger)lsPush
                       pushType:(NSInteger)pushType
                       timeFlag:(NSInteger)timeFlag
                           type:(NSInteger)type
                        version:(NSInteger)version;


@end

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
                       password:(NSString *)password;


@end

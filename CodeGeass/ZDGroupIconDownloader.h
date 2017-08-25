//
//  ZDGroupIconDownloader.h
//  CodeGeass
//
//  Created by ec on 2017/4/20.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDGroupModel.h"

@interface ZDGroupIconDownloader : NSObject

- (void)startWithId:(NSString *)Id type:(ZDGroupDataType)type success:(void(^)(UIImage *image))success;

@end

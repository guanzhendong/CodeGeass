
//
//  NSArray+ZDLogHelper.m
//  CodeGeass
//
//  Created by ec on 2017/5/31.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "NSArray+ZDLogHelper.h"

@implementation NSArray (ZDLogHelper)

#ifdef DEBUG
// NSLog数组对象时会调用此方法，将里面的中文在控制台打印出来，而不是显示unicode
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSString *logString;
        @try {
            logString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            logString = [NSString stringWithFormat:@"打印字典时转换失败：%@",exception.reason];
        } @finally {
            return logString;
        }
    }
    NSMutableString *string = [NSMutableString stringWithString:@"{\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    [string appendString:@"}\n"];
    return string;
}
#endif

@end

//
//  NSDictionary+ZDLogHelper.m
//  CodeGeass
//
//  Created by ec on 2017/1/5.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "NSDictionary+ZDLogHelper.h"

@implementation NSDictionary (ZDLogHelper)

#ifdef DEBUG
// NSLog字典对象时会调用此方法，将里面的中文在控制台打印出来，而不是显示unicode
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    // 此注释掉的版本有缺陷，当self里面包含json转换不支持的类型时会报错：Invalid type in JSON write
    /*
    NSString *logString;
    @try {
        logString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        logString = [NSString stringWithFormat:@"打印字典时转换失败：%@",exception.reason];
    } @finally {
        return logString;
    }
     */
    
    // 以下为两种方式结合处理
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
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [string appendString:@"}\n"];
    return string;
}
#endif

@end

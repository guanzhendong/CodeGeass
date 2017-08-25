//
//  NSDate+ZDAdd.m
//  CodeGeass
//
//  Created by ec on 2017/4/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "NSDate+ZDAdd.h"

@implementation NSDate (ZDAdd)

- (NSString *)sessionDateFormatStringLikeQQ {
    NSString *dateStr = @"";
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *nowDate = [NSDate date];
        NSDate *needFormatDate = self;
        
        // 取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        if (time<60*60*24) {// 在一天内的
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            if ([need_yMd isEqualToString:now_yMd]) {// 在今天
                // 获取系统是24小时制或者12小时制
                NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
                NSRange containsA = [formatStringForHours rangeOfString:@"a"];
                BOOL hasAMPM = containsA.location != NSNotFound;
                // hasAMPM==YES为12小时制，否则为24小时制
                if (hasAMPM) {
                    [dateFormatter setDateFormat:@"h:mm"];
                    if (needFormatDate.hour < 12) {
                        dateStr = [NSString stringWithFormat:@"上午%@",[dateFormatter stringFromDate:needFormatDate]];
                    } else {
                        dateStr = [NSString stringWithFormat:@"下午%@",[dateFormatter stringFromDate:needFormatDate]];
                    }
                } else {
                    [dateFormatter setDateFormat:@"HH:mm"];
                    dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
                }
            } else {
                //昨天
                dateStr = @"昨天";
            }
        }
        else if (time<60*60*24*2) {// 大于24小时可能是昨天
            if ([needFormatDate isYesterday]) {
                dateStr = @"昨天";
            } else {
                dateStr = [needFormatDate dayFromWeekday];
            }
        }
        else if (time<60*60*24*6) {// 一周内，修改60*60*24*7为60*60*24*6，参考QQ，假如今天是星期一，那么上周一不显示为“星期一”而显示日月，上周二才开始显示“星期几”
            dateStr = [needFormatDate dayFromWeekday];
        }
        else if (time<60*60*24*7) {// 大于24*7小时可能是一周内
            if ([[needFormatDate dateAfterDay:6] isToday]) {
                dateStr = [needFormatDate dayFromWeekday];
            } else {// = 7
                [dateFormatter setDateFormat:@"yyyy"];
                NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
                NSString *nowYear = [dateFormatter stringFromDate:nowDate];
                
                if ([yearStr isEqualToString:nowYear]) {// 在今年
                    [dateFormatter setDateFormat:@"MM-dd"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                } else {
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                }
            }
        }
        else {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {// 在今年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            } else {
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        return dateStr;
    }
}

- (NSString *)sessionDateFormatStringLikeWeChat {
    NSString *dateStr = @"";
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *nowDate = [NSDate date];
        NSDate *needFormatDate = self;
        
        // 取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        if (time<60*60*24) {// 在一天内的
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            if ([need_yMd isEqualToString:now_yMd]) {// 在今天
                // 获取系统是24小时制或者12小时制
                NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
                NSRange containsA = [formatStringForHours rangeOfString:@"a"];
                BOOL hasAMPM = containsA.location != NSNotFound;
                // hasAMPM==YES为12小时制，否则为24小时制
                if (hasAMPM) {
                    [dateFormatter setDateFormat:@"h:mm"];
                    if (needFormatDate.hour < 12) {
                        dateStr = [NSString stringWithFormat:@"上午%@",[dateFormatter stringFromDate:needFormatDate]];
                    } else {
                        dateStr = [NSString stringWithFormat:@"下午%@",[dateFormatter stringFromDate:needFormatDate]];
                    }
                } else {
                    [dateFormatter setDateFormat:@"HH:mm"];
                    dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
                }
            } else {
                //昨天
                dateStr = @"昨天";
            }
        }
        else if (time<60*60*24*2) {// 大于24小时可能是昨天
            if ([needFormatDate isYesterday]) {
                dateStr = @"昨天";
            } else {
                dateStr = [needFormatDate dayFromWeekday];
            }
        }
        else if (time<60*60*24*6) {// 一周内，修改60*60*24*7为60*60*24*6，参考QQ，假如今天是星期一，那么上周一不显示为“星期一”而显示日月，上周二才开始显示“星期几”
            dateStr = [needFormatDate dayFromWeekday];
        }
        else if (time<60*60*24*7) {// 大于24*7小时可能是一周内
            if ([[needFormatDate dateAfterDay:6] isToday]) {
                dateStr = [needFormatDate dayFromWeekday];
            } else {// = 7
                [dateFormatter setDateFormat:@"yy/M/d"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        else {
            [dateFormatter setDateFormat:@"yy/M/d"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        return dateStr;
    }
}

@end

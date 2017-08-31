//
//  NSString+ZDExtension.m
//  CodeGeass
//
//  Created by ec on 2017/3/31.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "NSString+ZDExtension.h"

@implementation NSString (ZDExtension)

- (BOOL)zd_isContainChinese {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:@"^[\u4E00-\u9FFF]+$"
                                                                             options:NSRegularExpressionCaseInsensitive
                                                                               error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (NSString *)zd_transformToPinyin {
    if (![self zd_isContainChinese]) {
        return self;
    }
    NSMutableString * mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return mutableString.lowercaseString;
}


- (NSString *)zd_transformToPinyinFirstLetter {
    if (![self zd_isContainChinese]) {
        return self;
    }
    NSString *temp;
    NSMutableString *stringM = [NSMutableString string];
    for (int i = 0; i < [self length]; i++) {
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        NSMutableString *mutableString = [NSMutableString stringWithString:temp];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        if (mutableString.length > 0) {
            mutableString = [[mutableString substringToIndex:1] mutableCopy];
            [stringM appendString:(NSString *)mutableString];
        }
    }
    return stringM.lowercaseString;
}

- (NSUInteger)zd_chineseAndEnglishLength {
    NSUInteger length = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            length++;
        }else {
            p++;
        }
    }
    return length;
}

- (NSUInteger)zd_asciiLength {
    NSUInteger asciiLength = 0;
    for (int i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

- (NSString *)zd_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (BOOL)zd_isBlank {
    return ([self zd_stringByTrim].length == 0);
}

- (BOOL)zd_isValid {
    return !(self == nil || [self isEqualToString:@"(null)"] || [self zd_isBlank]);
}

- (BOOL)zd_isValidSimpleMobile {
    if ([self hasPrefix:@"1"] && self.length == 11) {
        return YES;
    }
    return NO;
}

- (BOOL)zd_isValidMediumMobile {
    NSString *regex = @"^1(3|4|5|7|8)[0-9]\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)zd_isValidComplicatedMobile {
    if (![self zd_isValidSimpleMobile]) return NO;
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestmobile evaluateWithObject:self]
        || [regextestcm evaluateWithObject:self]
        || [regextestct evaluateWithObject:self]
        || [regextestcu evaluateWithObject:self])
    {
        return YES;
    }
    return NO;
}

- (BOOL)zd_isValidEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

- (BOOL)zd_isValidUrl {
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

@end

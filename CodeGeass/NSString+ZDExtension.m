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

- (BOOL)zd_isPureWhitespaceAndNewline {
    return ([self zd_stringByTrim].length == 0);
}

@end

//
//  NSString+ZDExtension.h
//  CodeGeass
//
//  Created by ec on 2017/3/31.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZDExtension)

/**
 是否包含汉字
 */
- (BOOL)zd_isContainChinese;

/**
 转换为拼音，你好==》nihao

 @return 不包含汉字时返回nil
 */
- (NSString *)zd_transformToPinyin;

/**
 转换为拼音首字母，你好==》nh

 @return 不包含汉字时返回nil
 */
- (NSString *)zd_transformToPinyinFirstLetter;


/**
 中英混合字符串长度（汉字长度为2，英文长度为1）

 @return 长度
 */
- (NSUInteger)zd_chineseAndEnglishLength;

/**
 字符串ascii长度（中英混合，汉字长度为2，英文长度为1）

 @return 长度
 */
- (NSUInteger)zd_asciiLength;


/**
 Trim blank characters (space and newline) in head and tail.

 @return the trimmed string.
 */
- (NSString *)zd_stringByTrim;

/**
 是否为纯空白

 @return BOOL
 */
- (BOOL)zd_isPureWhitespaceAndNewline;

@end

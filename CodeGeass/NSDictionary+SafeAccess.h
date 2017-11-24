//
//  NSDictionary+SafeAccess.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSDictionary
@interface NSDictionary (SafeAccess)

#pragma mark - OC对象
- (BOOL)sa_hasKey:(id)key;

- (id)sa_objectForKey:(id)key;

- (NSString *)sa_stringForKey:(id)key;

- (NSNumber *)sa_numberForKey:(id)key;

- (NSDecimalNumber *)sa_decimalNumberForKey:(id)key;

- (NSArray *)sa_arrayForKey:(id)key;

- (NSDictionary *)sa_dictionaryForKey:(id)key;

- (NSDate *)sa_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

#pragma mark - 简单数据
- (NSInteger)sa_integerForKey:(id)key;

- (NSUInteger)sa_unsignedIntegerForKey:(id)key;

- (BOOL)sa_boolForKey:(id)key;

- (int16_t)sa_int16ForKey:(id)key;

- (int32_t)sa_int32ForKey:(id)key;

- (int64_t)sa_int64ForKey:(id)key;

- (char)sa_charForKey:(id)key;

- (short)sa_shortForKey:(id)key;

- (float)sa_floatForKey:(id)key;

- (double)sa_doubleForKey:(id)key;

@end



#pragma mark - NSMutableDictionary
@interface NSMutableDictionary(SafeAccess)

- (void)sa_setObject:(id)anObject forKey:(id)aKey;

- (void)sa_removeObjectForKey:(id)aKey;

@end

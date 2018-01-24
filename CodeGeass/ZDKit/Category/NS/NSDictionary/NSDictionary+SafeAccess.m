//
//  NSDictionary+SafeAccess.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"

@implementation NSDictionary (SafeAccess)

- (BOOL)sa_hasKey:(id)key {
    return [self objectForKey:key] != nil;
}

- (id)sa_objectForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (NSString *)sa_stringForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if (!value
        || [[value description] isEqualToString:@"<null>"]
        || [[value description] isEqualToString:@"(null)"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
       return [value stringValue];
    }
    return nil;
}

- (NSNumber *)sa_numberForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSDecimalNumber *)sa_decimalNumberForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:value];
    }
    return nil;
}

- (NSArray *)sa_arrayForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)sa_dictionaryForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)sa_integerForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)sa_unsignedIntegerForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)sa_boolForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)sa_int16ForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}

- (int32_t)sa_int32ForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}

- (int64_t)sa_int64ForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)sa_charForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)sa_shortForKey:(id)key{
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}

- (float)sa_floatForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}

- (double)sa_doubleForKey:(id)key {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)sa_dateForKey:(id)key dateFormat:(NSString *)dateFormat {
    id value = [self sa_objectForKey:key];
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""]) {
        if (!dateFormat) {
            dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = dateFormat;
        return [formater dateFromString:value];
    }
    return nil;
}

@end



@implementation NSMutableDictionary (SafeAccess)

- (void)sa_setObject:(id)anObject forKey:(id)aKey {
    if (aKey && anObject) {
        self[aKey] = anObject;
    }
}

- (void)sa_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}

@end

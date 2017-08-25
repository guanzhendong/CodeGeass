//
//  NSArray+SafeAccess.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)sa_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        id object = self[index];
        if (object == [NSNull null]) {
            return nil;
        }
        return object;
    }
    return nil;
}

- (NSString *)sa_stringAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
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

- (NSNumber *)sa_numberAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
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

- (NSDecimalNumber *)sa_decimalNumberAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
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

- (NSArray *)sa_arrayAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)sa_dictionaryAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSDate *)sa_dateAtIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return nil;
    }
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

- (NSInteger)sa_integerAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)sa_unsignedIntegerAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)sa_boolAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)sa_int16AtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)sa_int32AtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}

- (int64_t)sa_int64AtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)sa_charAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)sa_shortAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
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

- (float)sa_floatAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}

- (double)sa_doubleAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    if (!value || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (CGFloat)sa_CGFloatAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    CGFloat f = [value doubleValue];
    return f;
}

- (CGPoint)sa_pointAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    CGPoint point = CGPointFromString(value);
    return point;
}

- (CGSize)sa_sizeAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    CGSize size = CGSizeFromString(value);
    return size;
}

- (CGRect)sa_rectAtIndex:(NSUInteger)index {
    id value = [self sa_objectAtIndex:index];
    CGRect rect = CGRectFromString(value);
    return rect;
}

@end



@implementation NSMutableArray (SafeAccess)

- (void)sa_addObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)sa_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

@end


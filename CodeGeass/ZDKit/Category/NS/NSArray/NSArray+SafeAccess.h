//
//  NSArray+SafeAccess.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSArray
@interface NSArray (SafeAccess)

#pragma mark - OC对象
- (id)sa_objectAtIndex:(NSUInteger)index;

- (NSString *)sa_stringAtIndex:(NSUInteger)index;

- (NSNumber *)sa_numberAtIndex:(NSUInteger)index;

- (NSDecimalNumber *)sa_decimalNumberAtIndex:(NSUInteger)index;

- (NSArray *)sa_arrayAtIndex:(NSUInteger)index;

- (NSDictionary *)sa_dictionaryAtIndex:(NSUInteger)index;

- (NSDate *)sa_dateAtIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

#pragma mark - 简单数据
- (NSInteger)sa_integerAtIndex:(NSUInteger)index;

- (NSUInteger)sa_unsignedIntegerAtIndex:(NSUInteger)index;

- (BOOL)sa_boolAtIndex:(NSUInteger)index;

- (int16_t)sa_int16AtIndex:(NSUInteger)index;

- (int32_t)sa_int32AtIndex:(NSUInteger)index;

- (int64_t)sa_int64AtIndex:(NSUInteger)index;

- (char)sa_charAtIndex:(NSUInteger)index;

- (short)sa_shortAtIndex:(NSUInteger)index;

- (float)sa_floatAtIndex:(NSUInteger)index;

- (double)sa_doubleAtIndex:(NSUInteger)index;

#pragma mark - CG
- (CGFloat)sa_CGFloatAtIndex:(NSUInteger)index;

- (CGPoint)sa_pointAtIndex:(NSUInteger)index;

- (CGSize)sa_sizeAtIndex:(NSUInteger)index;

- (CGRect)sa_rectAtIndex:(NSUInteger)index;

@end




#pragma mark - NSMutableArray
@interface NSMutableArray(SafeAccess)

- (void)sa_addObject:(id)anObject;

- (void)sa_removeObjectAtIndex:(NSUInteger)index;

@end

//
//  UIImage+ZDCompress.h
//  CodeGeass
//
//  Created by ec on 2017/4/26.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZDCompress)

/**
 将图片压缩到指定宽度，保持原来图片的宽高比

 @param width 图片宽度
 @return image
 */
- (UIImage *)zd_compressToWidth:(CGFloat)width;

/**
 将图片在子线程中压缩，block在主线层回调，保证压缩到指定大小，尽量减少失真
 
 @param length 大小，100K就是100*1024
 @param block 完成回调
 */
- (void)zd_compressToDataLength:(NSInteger)length block:(void(^)(NSData *data))block;

/**
 将图片在子线程中压缩，block在主线层回调，尽量压缩到指定大小，不一定满足条件，5M的图片就不能压缩到100K

 @param length 大小，100K就是100*1024
 @param block 完成回调
 */
- (void)zd_tryCompressToDataLength:(NSInteger)length block:(void(^)(NSData *data))block;

@end

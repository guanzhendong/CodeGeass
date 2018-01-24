//
//  UIImage+ZDCompress.m
//  CodeGeass
//
//  Created by ec on 2017/4/26.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIImage+ZDCompress.h"

@implementation UIImage (ZDCompress)

- (UIImage *)zd_compressToWidth:(CGFloat)width {
    if (width <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
    if (width >= self.size.width) return self;
    CGSize newSize = CGSizeMake(width, width * (self.size.height / self.size.width));
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)zd_compressToDataLength:(NSInteger)length block:(void(^)(NSData *data))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return;
    NSData *originalData = UIImagePNGRepresentation(self);
    if (length >= originalData.length) {
        block(originalData);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *newImage = [self copy];
        NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
        if (data.length / 1024 < 1024) {
            NSLog(@"图片压缩前的大小：%luKB", data.length / 1024);
        } else {
            NSLog(@"图片压缩前的大小：%.2fMB", (float)data.length / 1024 / 1024);
        }
        NSLog(@"------------------图片开始压缩------------------");
        CGFloat scale = 0.9;
        NSData *jpgData = UIImageJPEGRepresentation(newImage, scale);
        while (jpgData.length > length) {
            newImage = [newImage zd_compressToWidth:newImage.size.width * scale];
            NSData *newImageData = UIImageJPEGRepresentation(newImage, 0.0);
            if (newImageData.length < length) {
                newImageData = UIImageJPEGRepresentation(newImage, scale);
                while (newImageData.length > length) {
                    scale -= 0.1;
                    if (scale < 0) break;
                    newImageData = UIImageJPEGRepresentation(newImage, scale);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"------------------图片完成压缩------------------");
                    NSLog(@"图片压缩后的大小：%luKB", newImageData.length / 1024);
                    block(newImageData);
                });
                return;
            }
        }
    });
}

- (void)zd_tryCompressToDataLength:(NSInteger)length block:(void(^)(NSData *data))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return;
    NSData *originalData = UIImagePNGRepresentation(self);
    if (length >= originalData.length) {
        block(originalData);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = UIImageJPEGRepresentation(self, 1.0);
        if (data.length / 1024 < 1024) {
            NSLog(@"图片压缩前的大小：%luKB", data.length / 1024);
        } else {
            NSLog(@"图片压缩前的大小：%.2fMB", (float)data.length / 1024 / 1024);
        }
        NSLog(@"------------------图片开始压缩------------------");
        CGFloat scale = 0.9;
        NSData *scaleData = UIImageJPEGRepresentation(self, scale);
        while (scaleData.length > length) {
            scale -= 0.1;
            if (scale < 0) break;
            scaleData = UIImageJPEGRepresentation(self, scale);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"------------------图片完成压缩------------------");
            NSLog(@"图片压缩后的大小：%luKB", scaleData.length / 1024);
            block(scaleData);
        });
    });
}

@end

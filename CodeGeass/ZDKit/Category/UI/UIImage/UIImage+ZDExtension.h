//
//  UIImage+ZDExtension.h
//  CodeGeass
//
//  Created by ec on 2017/1/22.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageTextType) {
    /*
     text的第一个字
     */
    ImageTextTypeHead,
    /*
     text的最后两个字（“张三”取“张三”，“王小四”取“小四”）
     */
    ImageTextTypeTail,
};

typedef NS_ENUM(NSUInteger, ZDExtensionImageSize) {
    /* 30x30 */
    ZDExtensionImageSizeSmall,
    /* 60x60 */
    ZDExtensionImageSizeMiddle,
    /* 90x90 */
    ZDExtensionImageSizeLarge,
};

@interface UIImage (ZDExtension)

/**
 创建图片：随机色，大小30x30，圆形

 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_smallImageWithText:(NSString *)text;
/**
 创建图片：随机色，大小60x60，圆形
 
 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_middleImageWithText:(NSString *)text;
/**
 创建图片：随机色，大小90x90，圆形
 
 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_largeImageWithText:(NSString *)text;

/**
 创建图片：随机色，圆形

 @param sizeType 大小
 @param text 文字
 @param textType 截取文字类型
 @return 图片
 */
+ (UIImage *)zd_imageWithSizeType:(ZDExtensionImageSize)sizeType
                             text:(NSString *)text
                         textType:(ImageTextType)textType;


/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular;

@end

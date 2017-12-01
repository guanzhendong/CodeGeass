//
//  UIImage+ZDExtension.m
//  CodeGeass
//
//  Created by ec on 2017/1/22.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIImage+ZDExtension.h"

@implementation UIImage (ZDExtension)

/**
 创建图片：随机色，大小30x30，圆形
 
 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_smallImageWithText:(NSString *)text {
    return [self zd_imageWithSizeType:ZDExtensionImageSizeSmall text:text];
}

/**
 创建图片：随机色，大小60x60，圆形
 
 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_middleImageWithText:(NSString *)text {
    return [self zd_imageWithSizeType:ZDExtensionImageSizeMiddle text:text];
}

/**
 创建图片：随机色，大小90x90，圆形
 
 @param text 文字
 @return 图片
 */
+ (UIImage *)zd_largeImageWithText:(NSString *)text {
    return [self zd_imageWithSizeType:ZDExtensionImageSizeLarge text:text];
}

+ (UIImage *)zd_imageWithSizeType:(ZDExtensionImageSize)sizeType
                             text:(NSString *)text
{
    return [self zd_imageWithSizeType:sizeType
                                 text:text
                             textType:ImageTextTypeTail];
}

+ (UIImage *)zd_imageWithSizeType:(ZDExtensionImageSize)sizeType
                             text:(NSString *)text
                         textType:(ImageTextType)textType
{
    YYImageCache *cache = [YYImageCache sharedCache];
    UIImage *cachedImage = [cache getImageForKey:text];
    if (cachedImage) {
        return cachedImage;
    }
    UIImage *image = [self imageWithSizeType:sizeType text:text textType:textType];
    [cache setImage:image forKey:text];
    return image;
}


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
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Private
+ (UIColor *)randomColor {
    
    float red = 0;
    while (red < 0.1 || red > 0.9) {
        red = (float)(arc4random()%255)/255;
    }
    
    float green = 0;
    while (green < 0.1 || green > 0.9) {
        green = (float)(arc4random()%255)/255;
    }
    
    float blue = 0;
    while (blue < 0.1 || blue > 0.9) {
        blue = (float)(arc4random()%255)/255;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIImage *)imageWithSizeType:(ZDExtensionImageSize)sizeType
                             text:(NSString *)text
                         textType:(ImageTextType)textType
{
    // size
    CGSize size = CGSizeZero;
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    CGFloat fontSize = 0;
    switch (sizeType) {
        case ZDExtensionImageSizeSmall:
        {
            size = CGSizeMake(30, 30);
            if (text.length == 1) {
                fontSize = 12;
            }else if (text.length >= 2) {
                fontSize = 9;
            }
        }
            break;
        case ZDExtensionImageSizeMiddle:
        {
            size = CGSizeMake(60, 60);
            if (text.length == 1) {
                fontSize = 24;
            }else if (text.length >= 2) {
                fontSize = 18;
            }
        }
            break;
        case ZDExtensionImageSizeLarge:
        {
            size = CGSizeMake(90, 90);
            if (text.length == 1) {
                fontSize = 36;
            }else if (text.length >= 2) {
                fontSize = 27;
            }
        }
            break;
        default:
            break;
    }
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    
    // color
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    CGContextFillRect(context, rect);
    
    // text
    if ([text isKindOfClass:[NSNull class]]
        || [text isEqualToString:@"<null>"]
        || [text isEqualToString:@"(null)"]) {
        text = @"";
    }
    switch (textType) {
        case ImageTextTypeHead:
        {
            if (text.length > 1) {
                text = [text substringToIndex:1];
            }
        }
            break;
        case ImageTextTypeTail:
        {
            if (text.length > 2) {
                text = [text substringFromIndex:text.length - 2];
            }
        }
            break;
        default:
            break;
    }
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

//
//  ZDCommonTool.h
//  ECLite
//
//  Created by ec on 16/7/28.
//  Copyright © 2016年 eclite. All rights reserved.
//

/**
 *  本类收集一些常用的方法
 */

#import <Foundation/Foundation.h>

@interface ZDCommonTool : NSObject

/**
 *  绘制虚线
 *
 *  @param lineFrame 虚线的 frame
 *  @param length    虚线中短线的宽度
 *  @param spacing   虚线中短线之间的间距
 *  @param color     虚线中短线的颜色
 *
 *  @return 虚线view
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

/**
 *  给一个view添加一个类似bounce的动画
 *
 *  @param view       目标view
 *  @param completion 动画完成回调
 */
+ (void)addBounceAnimationToView:(UIView *)view completion:(void(^)())completion;

/**
 判断是否第一次启动此版本的App

 @return bool
 */
+ (BOOL)checkFirstLaunchingApplication;

/**
 拉伸图片

 @param image 图片
 @return 拉伸后的图片
 */
+ (UIImage *)resizeImage:(UIImage *)image;

/**
 取图片某一像素的颜色

 @param image 图片
 @param point 点
 @return color
 */
+ (UIColor *)colorForImage:(UIImage *)image atPixel:(CGPoint)point;

/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
                       text:(NSString *)text
             textAttributes:(NSDictionary *)textAttributes
                   circular:(BOOL)isCircular;

/**
 二维码图片生成
 
 @param string 内容
 @param size 大小，例如150x150
 @return 图片
 */
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size;


@end

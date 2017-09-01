//
//  UIImageView+ZDAddForSDWebImage.h
//  CodeGeass
//
//  Created by ec on 2017/8/31.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

// 存储的图片是处理过的图片，在需求变更时需要做版本控制，所以还是存原图比较好，并不是一个好方案

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (ZDAddForSDWebImage)<SDWebImageManagerDelegate>

@property (nonatomic, assign, readonly) CGFloat zd_cornerRadius;

/**
 对SDWebImage下载完的图片做圆角处理

 @param cornerRadius cornerRadius
 */
- (void)sd_setImageWithURL:(nullable NSURL *)url
              cornerRadius:(CGFloat)cornerRadius
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

@end

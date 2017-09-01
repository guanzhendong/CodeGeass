//
//  UIImageView+ZDAddForSDWebImage.m
//  CodeGeass
//
//  Created by ec on 2017/8/31.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIImageView+ZDAddForSDWebImage.h"

@implementation UIImageView (ZDAddForSDWebImage)

static const void *zd_cornerRadiusKey = &zd_cornerRadiusKey;
- (CGFloat)zd_cornerRadius {
    return [objc_getAssociatedObject(self, zd_cornerRadiusKey) doubleValue];
}

- (void)setZd_cornerRadius:(CGFloat)zd_cornerRadius {
    objc_setAssociatedObject(self, zd_cornerRadiusKey, @(zd_cornerRadius), OBJC_ASSOCIATION_ASSIGN);
}

- (void)sd_setImageWithURL:(nullable NSURL *)url
              cornerRadius:(CGFloat)cornerRadius
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock
{
    self.zd_cornerRadius = cornerRadius;
    SDWebImageManager.sharedManager.delegate = self;
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
    return [image imageByRoundCornerRadius:self.zd_cornerRadius];
}

@end

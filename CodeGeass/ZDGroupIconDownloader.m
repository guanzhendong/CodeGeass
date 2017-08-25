//
//  ZDGroupIconDownloader.m
//  CodeGeass
//
//  Created by ec on 2017/4/20.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDGroupIconDownloader.h"
#import "YYImageCache+ZDGroupIconCache.h"

@interface ZDGroupIconDownloader ()
@property (nonatomic, copy) void (^success)(UIImage *image);
@end

@implementation ZDGroupIconDownloader {
    NSString *_Id;
    ZDGroupDataType _type;
    NSMutableArray *_images;
    NSInteger _successCount;
    NSInteger _failureCount;
    NSInteger _index;
}

- (void)startWithId:(NSString *)Id type:(ZDGroupDataType)type success:(void(^)(UIImage *image))success {
    _Id = Id;
    _type = type;
    _success = success;
    _images = [NSMutableArray array];
    _successCount = 0;
    _failureCount = 0;
    _index = 0;
    
    if (type == ZDGroupDataTypeGroup) {
        [[ZDGroupManager sharedManager] requestGroupMemberListWithGroupId:Id timestamp:0 success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp) {
            if (returnCode == 0) {
                [self setupCount];
            }
        } failure:^(NSInteger errorCode, NSString *errorMsg) {
            
        }];
    } else if (type == ZDGroupDataTypeDiscuss) {
        [[ZDGroupManager sharedManager] requestDiscussMemberListWithGroupId:Id timestamp:0 success:^(NSInteger returnCode, NSString *returnMsg, id data, NSTimeInterval timestamp) {
            if (returnCode == 0) {
                [self setupCount];
            }
        } failure:^(NSInteger errorCode, NSString *errorMsg) {
            
        }];
    }
}

- (void)setupCount {
    ZDGroupModel *model = [[ZDGroupManager sharedManager] groupWithId:_Id type:_type];
    if (model.members.count < 2) {
        return;
    }
    NSInteger showCount = 2;
    if (model.members.count < 4) {// 3人或3人以下
        showCount = model.members.count;
    } else {// 4人或4人以上
        showCount = 4;
    }
    
    [self downloadImageWithGroupMember:model.members totalCount:showCount completion:^(BOOL success, NSArray *imageArray) {
        if (success) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self setup:imageArray];
            });
        } else {
           
        }
    }];
}

- (void)setup:(NSArray<UIImage *> *)imageArray {
    CGFloat length = 25;
    CGFloat margin = 0.5;
    CGSize size = CGSizeMake(length * 2 + margin, length * 2 + margin);
    UIImage *image;
    switch (imageArray.count) {
        case 2:
        {
            image =
            [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
                UIImage *fisrtImage = [imageArray sa_objectAtIndex:0];
                // 人的头像一般居中，所以取图片中间2/3的宽度
                fisrtImage = [fisrtImage imageByCropToRect:CGRectMake(fisrtImage.size.width / 6, 0, fisrtImage.size.width * 2 / 3, fisrtImage.size.height)];
                [fisrtImage drawInRect:CGRectMake(-length / 3, 0, length * 4 / 3, length * 2)
                       withContentMode:UIViewContentModeScaleAspectFill
                         clipsToBounds:NO];
                UIImage *secondImage = [imageArray sa_objectAtIndex:1];
                secondImage = [secondImage imageByCropToRect:CGRectMake(secondImage.size.width / 6, 0, secondImage.size.width * 2 / 3, secondImage.size.height)];
                [secondImage drawInRect:CGRectMake(length + margin, 0, length * 4 / 3, length * 2)
                        withContentMode:UIViewContentModeScaleAspectFill
                          clipsToBounds:NO];
            }];
        }
            break;
        case 3:
        {
            image =
            [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
                [[imageArray sa_objectAtIndex:0] drawInRect:CGRectMake(0, 0, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
                [[imageArray sa_objectAtIndex:1] drawInRect:CGRectMake(0, length + margin, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
                UIImage *thirdImage = [imageArray sa_objectAtIndex:2];
                thirdImage = [thirdImage imageByCropToRect:CGRectMake(thirdImage.size.width / 6, 0, thirdImage.size.width * 2 / 3, thirdImage.size.height)];
                [thirdImage drawInRect:CGRectMake(length + margin, 0, length * 4 / 3, length * 2)
                       withContentMode:UIViewContentModeScaleAspectFill
                         clipsToBounds:NO];
            }];
        }
            break;
        case 4:
        {
            image =
            [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
                [[imageArray sa_objectAtIndex:0] drawInRect:CGRectMake(0, 0, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
                [[imageArray sa_objectAtIndex:1] drawInRect:CGRectMake(0, length + margin, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
                [[imageArray sa_objectAtIndex:2] drawInRect:CGRectMake(length + margin, 0, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
                [[imageArray sa_objectAtIndex:3] drawInRect:CGRectMake(length + margin, length + margin, length, length)
                                           withContentMode:UIViewContentModeScaleAspectFill
                                             clipsToBounds:NO];
            }];
        }
            break;
        default:
            break;
    }
    UIImage *finalImage = [image imageByRoundCornerRadius:length];
    if (finalImage) {
        [[YYImageCache groupIconCache] setImage:finalImage forKey:[NSString stringWithFormat:@"%@_%@",ZD_USERID,_Id]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_success) {
                _success(finalImage);
            }
        });
    }
}

- (void)downloadImageWithGroupMember:(NSArray *)arrayMember
                          totalCount:(NSInteger)totalCount
                          completion:(void(^)(BOOL success, NSArray *imageArray))completion
{
    NSString *urlStr = ((ZDContactModel *)[arrayMember sa_objectAtIndex:_index]).face;
    [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        _index ++;
        if (image && !error) {
            _successCount++;
            [_images addObject:image];
            if (_images.count == totalCount) {
                NSLog(@"图片组下载完成");
                if (completion) {
                    completion(YES,_images);
                }
            } else {
                [self downloadImageWithGroupMember:arrayMember totalCount:totalCount completion:completion];
            }
        } else {
            _failureCount++;
            if (_failureCount < 4) {// 失败3次不再请求
                [self downloadImageWithGroupMember:arrayMember totalCount:totalCount completion:completion];
            } else {
                NSLog(@"图片组下载失败");
                if (completion) {
                    completion(NO,nil);
                }
            }
        }
    }];
}

@end

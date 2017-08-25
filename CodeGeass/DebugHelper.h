//
//  DebugHelper.h
//  EVClub
//
//  Created by Eddit on 16/5/14.
//  Copyright (c) 2015年 ECLite. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DebugHelper : NSObject
@property(nonatomic, copy) NSString * server;
#ifdef DEBUG
@property (nonatomic, strong) UILabel *debugLabel;//导航条上显示的“内外网”label
@property (nonatomic, strong) UILabel *fpsLabel;
#endif
@property(nonatomic) BOOL needLog;//是否在桌面上输出日志
+ (DebugHelper *)sharedInstance;
+ (void)setup;
+ (void)showMemoryUseage;
- (void)setDebug:(BOOL)debug;
- (void)updateLabel;

@end

@interface NSObject(DebugHelper)

@end


@interface UIView(ergodicAndSetFrame)
- (void)ergodicSubviewsWithBlock:(BOOL(^)(UIView *view))handler
                        DeepLoop:(BOOL)deepLoop;
@end

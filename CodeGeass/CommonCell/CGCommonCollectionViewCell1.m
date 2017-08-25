//
//  CGCommonCollectionViewCell1.m
//  ECLite
//
//  Created by ec on 2016/11/24.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "CGCommonCollectionViewCell1.h"

@implementation CGCommonCollectionViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        _maskImageView.image = [UIImage imageNamed:@"filter_circle_mask_highlighted"];
    }else {
        _maskImageView.image = [UIImage imageNamed:@"filter_circle_mask"];
    }
}

@end

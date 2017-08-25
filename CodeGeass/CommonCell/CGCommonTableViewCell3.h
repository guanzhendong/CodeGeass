//
//  CGCommonTableViewCell3.h
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCommonTableViewCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;///< 默认隐藏
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;///< 默认隐藏，宽高15x15

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewHeightConstraint;///<左图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelWidthConstraint;///<右标签宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelRightConstraint;///< 右三角隐藏时为15，显示时为35=10+15+10
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineViewLeftConstraint;///< 默认15

/**
 显示或隐藏右三角
 
 @param show 显示为YES
 */
- (void)showRightArrow:(BOOL)show;

@end

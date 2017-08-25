//
//  CGCommonTableViewCell1.h
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCommonTableViewCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;///< 默认隐藏
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;///< 默认隐藏，宽高15x15

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewHeightConstraint;///< 左图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineViewLeftConstraint;///< 默认15
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelRightConstraint;///< 右三角隐藏时为15，显示时为35=10+15+10


/**
 显示或隐藏右三角
 
 @param show 显示为YES
 */
- (void)showRightArrow:(BOOL)show;

@end

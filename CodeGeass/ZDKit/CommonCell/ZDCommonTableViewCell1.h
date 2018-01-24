//
//  ZDCommonTableViewCell1.h
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "ZDBaseTableViewCell.h"

@interface ZDCommonTableViewCell1 : ZDBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;///< 默认隐藏，宽高15x15

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewHeightConstraint;///< 左图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelRightConstraint;///< 右三角隐藏时为15，显示时为35=10+15+10

@end

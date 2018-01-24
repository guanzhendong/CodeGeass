//
//  ZDCommonTableViewCell4.h
//  ECLite
//
//  Created by ec on 2016/11/29.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "ZDBaseTableViewCell.h"

@interface ZDCommonTableViewCell4 : ZDBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;///< 默认隐藏，宽高15x15

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelLeftConstraint;///< 右label到左边框的间距，默认100
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelRightConstraint;///< 右三角隐藏时为15，显示时为35=10+15+10

@end

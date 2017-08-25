//
//  CGCommonTableViewCell4.m
//  ECLite
//
//  Created by ec on 2016/11/29.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "CGCommonTableViewCell4.h"

@implementation CGCommonTableViewCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _leftLabel.textColor = [UIColor zd_mainTitleColor];
    _rightLabel.textColor = [UIColor zd_mainContentColor];
    _bottomLineView.backgroundColor = [UIColor zd_separatorColor];
}

- (void)showRightArrow:(BOOL)show {
    _rightArrowImageView.hidden = !show;
    if (show) {
        _rightLabelRightConstraint.constant = 35;
    } else {
        _rightLabelRightConstraint.constant = 15;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

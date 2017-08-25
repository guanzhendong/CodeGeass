//
//  CGCommonTableViewCell3.m
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "CGCommonTableViewCell3.h"

@implementation CGCommonTableViewCell3

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

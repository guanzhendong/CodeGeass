//
//  ZDCommonTableViewCell3.m
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "ZDCommonTableViewCell3.h"

@implementation ZDCommonTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _leftLabel.textColor = [UIColor zd_mainTitleColor];
    _rightLabel.textColor = [UIColor zd_mainContentColor];
}

- (void)setShowsIndicator:(BOOL)showsIndicator {
    [super setShowsIndicator:showsIndicator];
    if (showsIndicator) {
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

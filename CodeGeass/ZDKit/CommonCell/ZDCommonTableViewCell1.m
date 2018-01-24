//
//  ZDCommonTableViewCell1.m
//  ECLite
//
//  Created by ec on 16/4/27.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "ZDCommonTableViewCell1.h"

@implementation ZDCommonTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _topLabel.textColor = [UIColor zd_mainTitleColor];
    _bottomLabel.textColor = [UIColor zd_mainContentColor];
}

- (void)setShowsIndicator:(BOOL)showsIndicator {
    [super setShowsIndicator:showsIndicator];
    if (showsIndicator) {
        _topLabelRightConstraint.constant = 35;
    } else {
        _topLabelRightConstraint.constant = 15;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

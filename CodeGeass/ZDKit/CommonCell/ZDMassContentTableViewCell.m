//
//  ZDMassContentTableViewCell.m
//  ECLite
//
//  Created by ec on 2016/11/30.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import "ZDMassContentTableViewCell.h"

@implementation ZDMassContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.textColor = [UIColor zd_mainTitleColor];
    _contentLabel.textColor = [UIColor zd_mainContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZDBaseTableViewCell.m
//  CodeGeass
//
//  Created by ec on 2017/11/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "ZDBaseTableViewCell.h"

@interface ZDBaseTableViewCell ()

@property (nonatomic, strong) CALayer *separatorLayer;
@property (nonatomic, strong) CALayer *highlightedBackgroundView;

@end

@implementation ZDBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 默认15
    _separatorLeading = 15.f;
    _showsSeparator = YES;
    
    // 设置选中颜色
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor zd_separatorColor];
    
    // 设置分隔线
    _separatorLayer = [[CALayer alloc] init];
    _separatorLayer.backgroundColor = [UIColor zd_separatorColor].CGColor;
    [self.layer addSublayer:_separatorLayer];
}

- (void)setShowsSeparator:(BOOL)showsSeparator {
    _showsSeparator = showsSeparator;
    _separatorLayer.hidden = !showsSeparator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_showsSeparator) {
        [UIView setAnimationsEnabled:NO];
        self.separatorLayer.frame = CGRectMake(_separatorLeading, CGRectGetHeight(self.bounds) - SINGLE_LINE_ADJUST_OFFSET, CGRectGetWidth(self.bounds) - _separatorLeading, SINGLE_LINE_HEIGHT);
        [UIView setAnimationsEnabled:YES];
    }
}

@end

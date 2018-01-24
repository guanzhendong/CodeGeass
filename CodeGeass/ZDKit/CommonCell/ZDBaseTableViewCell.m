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
@property (nonatomic, strong) UIImageView *customAccessoryView;

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
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor zd_separatorColor];
    
    // 设置分隔线
    _separatorLayer = [[CALayer alloc] init];
    _separatorLayer.backgroundColor = [UIColor zd_separatorColor].CGColor;
    [self.layer addSublayer:_separatorLayer];
}

- (UIImageView *)customAccessoryView {
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIImageView alloc] init];
        [self.contentView addSubview:_customAccessoryView];
    }
    return _customAccessoryView;
}

- (void)setShowsSeparator:(BOOL)showsSeparator {
    _showsSeparator = showsSeparator;
    _separatorLayer.hidden = !showsSeparator;
}

- (void)setShowsIndicator:(BOOL)showsIndicator {
    self.customAccessoryView.hidden = !showsIndicator;
    UIImage *image = [UIImage imageNamed:@"cell_arrow_right_gray"];
    self.customAccessoryView.image = image;
    self.customAccessoryView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 10 - image.size.width, (CGRectGetHeight(self.bounds) - image.size.height) / 2, image.size.width, image.size.height);
}

- (void)setShowsCheckmark:(BOOL)showsCheckmark {
    UIImage *image = showsCheckmark ? [UIImage imageNamed:@"cell_mark_select"] : [UIImage imageNamed:@"cell_mark_normal"];
    self.customAccessoryView.image = image;
    self.customAccessoryView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 10 - image.size.width, (CGRectGetHeight(self.bounds) - image.size.height) / 2, image.size.width, image.size.height);
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

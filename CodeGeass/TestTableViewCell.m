//
//  TestTableViewCell.m
//  CodeGeass
//
//  Created by ec on 2017/10/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "TestTableViewCell.h"
#import "UIResponder+ZDRouter.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)leftClicked:(id)sender {
    [self zd_routerEventWithName:@"leftClicked" userInfo:nil];
}
- (IBAction)rightClicked:(id)sender {
    [self zd_routerEventWithName:@"rightClicked" userInfo:nil];
}

@end

//
//  UIAlertController+ZDExtension.m
//  CodeGeass
//
//  Created by ec on 2017/5/26.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIAlertController+ZDExtension.h"

@implementation UIAlertAction (ZDExtension)

- (void)zd_setTitleColor:(UIColor *)color {
    [self setValue:color forKey:@"titleTextColor"];
}

@end

@implementation UIAlertController (ZDExtension)

- (void)zd_setTitleColor:(UIColor *)color {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:self.title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:color}];
    [self zd_setAttributedTitle:string];
}

- (void)zd_setAttributedTitle:(NSAttributedString *)title {
    [self setValue:title forKey:@"attributedTitle"];
}

- (void)zd_setMessageColor:(UIColor *)color {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:self.message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:color}];
    [self zd_setAttributedMessage:string];
}

- (void)zd_setAttributedMessage:(NSAttributedString *)message {
    [self setValue:message forKey:@"attributedMessage"];
}

- (void)zd_setActionTitleColor:(UIColor *)color {
    for (UIAlertAction *action in self.actions) {
        [action zd_setTitleColor:color];
    }
}

@end

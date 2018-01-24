//
//  UITextView+ZDKeyboard.m
//  CodeGeass
//
//  Created by ec on 2017/4/24.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UITextView+ZDKeyboard.h"

@implementation UITextView (ZDKeyboard)

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)zd_setupKeyboardAvoid {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)handleKeyboardDidShow:(NSNotification *)noti {
    CGRect frame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y < [UIScreen mainScreen].bounds.size.height) {
        UIEdgeInsets contentInset = self.contentInset;
        contentInset.bottom = frame.size.height;
        self.contentInset = contentInset;
    }
}

- (void)handleKeyboardDidHide:(NSNotification *)noti {
    CGRect frame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y >= [UIScreen mainScreen].bounds.size.height) {
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets contentInset = self.contentInset;
            contentInset.bottom = 0;
            self.contentInset = contentInset;
        }];
    }
}

@end

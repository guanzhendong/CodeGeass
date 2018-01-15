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



+ (instancetype)zd_alertWithTitle:(nullable NSString *)title
                          message:(nullable NSString *)message
                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                          clicked:(nullable void(^)(NSUInteger buttonIndex))clickedHandler
                otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelButtonTitle) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancel];
    }
    
    id eachObject;
    va_list argumentList;
    NSMutableArray *tempOtherButtonTitles = nil;
    if (otherButtonTitles) {
        tempOtherButtonTitles = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
        va_start(argumentList, otherButtonTitles);
        while ((eachObject = va_arg(argumentList, id))) {
            [tempOtherButtonTitles addObject:eachObject];
        }
        va_end(argumentList);
        
        [tempOtherButtonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (clickedHandler) {
                        clickedHandler(idx);
                    }
                }];
                [controller addAction:action];
            }
        }];
    }
    return controller;
}

+ (instancetype)zd_actionSheetWithTitle:(nullable NSString *)title
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                clicked:(nullable void(^)(NSUInteger buttonIndex))clickedHandler
                      otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancelButtonTitle) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancel];
    }
    
    id eachObject;
    va_list argumentList;
    NSMutableArray *tempOtherButtonTitles = nil;
    if (otherButtonTitles) {
        tempOtherButtonTitles = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
        va_start(argumentList, otherButtonTitles);
        while ((eachObject = va_arg(argumentList, id))) {
            [tempOtherButtonTitles addObject:eachObject];
        }
        va_end(argumentList);
        
        [tempOtherButtonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (clickedHandler) {
                        clickedHandler(idx);
                    }
                }];
                [controller addAction:action];
            }
        }];
    }
    return controller;
}

@end

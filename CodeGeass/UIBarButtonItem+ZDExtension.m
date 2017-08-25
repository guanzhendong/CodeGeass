//
//  UIBarButtonItem+ZDExtension.m
//  CodeGeass
//
//  Created by ec on 2017/1/4.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import "UIBarButtonItem+ZDExtension.h"

@implementation UIBarButtonItem (ZDExtension)

+ (instancetype)itemWithTitle:(NSString *)title
                       target:(id)target
                       action:(SEL)action
{
    return [self itemWithTitle:title
                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]}
                        target:target
                        action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title
                   attributes:(NSDictionary *)attributes
                       target:(id)target
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:attributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    button.titleLabel.font = attributes[NSFontAttributeName];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImage:(NSString *)image
                       target:(id)target
                       action:(SEL)action
{
    return [self itemWithImage:image
              highlightedImage:nil
                        target:target
                        action:action];
}

+ (instancetype)itemWithImage:(NSString *)image
             highlightedImage:(NSString *)highlightedImage
                       target:(id)target
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end

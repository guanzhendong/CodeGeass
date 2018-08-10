//
//  UICreator.m
//  CodeGeass
//
//  Created by ec on 2018/8/10.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import "UICreator.h"
#import "UIControl+YYAdd.h"
#import "UIGestureRecognizer+YYAdd.h"

@implementation UICreator

#pragma mark - For UIView
+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor
{
    return [self createViewWithFrame:frame bgColor:bgColor cornerRadius:0 actionGesture:NULL];
}

+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor
                   cornerRadius:(CGFloat)cornerRadius
{
    return [self createViewWithFrame:frame bgColor:bgColor cornerRadius:cornerRadius actionGesture:NULL];
}

+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor
                   cornerRadius:(CGFloat)cornerRadius
                  actionGesture:(UIGestureRecognizer *)gesture
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    view.clipsToBounds = YES;// view一般会有子视图，所以需要设置此值
    view.layer.cornerRadius = cornerRadius;
    [view addGestureRecognizer:gesture];
    return view;
}

+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor
                   cornerRadius:(CGFloat)cornerRadius
                      tapAction:(void(^)())tapAction
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        if (tapAction) {
            tapAction();
        }
    }];
    return [self createViewWithFrame:frame bgColor:bgColor cornerRadius:cornerRadius actionGesture:tap];
}

#pragma mark - For UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
{
    return [self createLabelWithFrame:frame
                                 text:text
                        textAlignment:0
                             fontSize:0
                            textColor:nil
                              bgColor:nil
                         cornerRadius:0
                            tapAction:nil];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
{
    return [self createLabelWithFrame:frame
                                 text:text
                        textAlignment:textAlignment
                             fontSize:fontSize
                            textColor:nil
                              bgColor:nil
                         cornerRadius:0
                            tapAction:nil];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
{
    return [self createLabelWithFrame:frame
                                 text:text
                        textAlignment:textAlignment
                             fontSize:fontSize
                            textColor:textColor
                              bgColor:nil
                         cornerRadius:0
                            tapAction:nil];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor
{
    return [self createLabelWithFrame:frame
                                 text:text
                        textAlignment:textAlignment
                             fontSize:fontSize
                            textColor:textColor
                              bgColor:bgColor
                         cornerRadius:0
                            tapAction:nil];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
{
    return [self createLabelWithFrame:frame
                                 text:text
                        textAlignment:textAlignment
                             fontSize:fontSize
                            textColor:textColor
                              bgColor:bgColor
                         cornerRadius:cornerRadius
                            tapAction:nil];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
                        tapAction:(void(^)())tapAction
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = textAlignment;
    if (fontSize > 0) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.layer.cornerRadius = cornerRadius;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        if (tapAction) {
            tapAction();
        }
    }];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tap];
    return label;
}

#pragma mark - For UIButton
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                             action:(void(^)())action
{
    return [self createButtonWithFrame:frame
                                 title:title
                              fontSize:0
                            titleColor:nil
                               bgColor:nil
                          cornerRadius:0
                                action:action];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                             action:(void(^)())action
{
    return [self createButtonWithFrame:frame
                                 title:title
                              fontSize:fontSize
                            titleColor:nil
                               bgColor:nil
                          cornerRadius:0
                                action:action];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                             action:(void(^)())action
{
    return [self createButtonWithFrame:frame
                                 title:title
                              fontSize:fontSize
                            titleColor:titleColor
                               bgColor:bgColor
                          cornerRadius:0
                                action:nil];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                       cornerRadius:(CGFloat)cornerRadius
                             action:(void(^)())action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = cornerRadius;
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if (action) {
            action();
        }
    }];
    return button;
}

#pragma mark - For UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
{
    return [self createImageViewWithFrame:frame
                                imageName:imageName
                             cornerRadius:0
                            actionGesture:nil];
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                             cornerRadius:(CGFloat)cornerRadius
{
    return [self createImageViewWithFrame:frame
                                imageName:nil
                             cornerRadius:cornerRadius
                            actionGesture:nil];
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                             cornerRadius:(CGFloat)cornerRadius
                            actionGesture:(UIGestureRecognizer *)gesture
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:imageName];
    imageView.layer.cornerRadius = cornerRadius;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    return imageView;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                             cornerRadius:(CGFloat)cornerRadius
                                tapAction:(void(^)())tapAction
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        if (tapAction) {
            tapAction();
        }
    }];
    return [self createImageViewWithFrame:frame
                                imageName:imageName
                             cornerRadius:cornerRadius
                            actionGesture:tap];
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                              roundCorner:(BOOL)roundCorner
                                tapAction:(void(^)())tapAction
{
    CGFloat cornerRadius = 0;
    if (roundCorner) {
        cornerRadius = MIN(frame.size.width, frame.size.height) / 2;
    }
    return [self createImageViewWithFrame:frame
                                imageName:imageName
                             cornerRadius:cornerRadius
                                tapAction:tapAction];
}

#pragma mark ----------------------------------以上已重写，添加frame----------------------------------
#pragma mark -

//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                         titleColor:(UIColor *)titleColor
//                               font:(UIFont *)font
//                             target:(id)target
//                             action:(SEL)action
//{
//    return [self createButtonWithTitle:title
//                            titleColor:titleColor
//                                  font:font
//                            buttonType:UIButtonTypeCustom
//                               bgColor:nil
//                                corner:0
//                                target:self
//                                action:action];
//}
//
//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                         titleColor:(UIColor *)titleColor
//                               font:(UIFont *)font
//                         buttonType:(UIButtonType)buttonType
//                            bgColor:(UIColor *)bgColor
//                             corner:(float)cornerRadius
//                             target:(id)target
//                             action:(SEL)action
//{
//    UIButton *button = [UIButton buttonWithType:buttonType];
//    [button setTitle:title forState:UIControlStateNormal];
//    if (titleColor) {
//        [button setTitleColor:titleColor forState:UIControlStateNormal];
//    }
//    if (font) {
//        button.titleLabel.font = font;
//    }
//    if (bgColor) {
//        button.backgroundColor = bgColor;
//    }
//    if (cornerRadius > 0) {
//        button.layer.cornerRadius = cornerRadius;
//    }
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
//
//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                              image:(NSString *)imageName
//                          titleEdge:(UIEdgeInsets)titleEdge
//                          imageEdge:(UIEdgeInsets)imageEdge
//                             target:(id)target
//                             action:(SEL)action
//{
//    UIButton *button = [self createButtonWithTitle:title titleColor:nil font:nil target:target action:action];
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setTitleEdgeInsets:titleEdge];
//    [button setImageEdgeInsets:imageEdge];
//    return button;
//}
//
//+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
//                         highlightedImage:(NSString *)highlightedImageName
//                                   target:(id)target
//                                   action:(SEL)action
//{
//    UIButton *button = [self createButtonWithTitle:nil titleColor:nil font:nil target:target action:action];
//    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
//    CGSize size = [button imageForState:UIControlStateNormal].size;
//    button.bounds = CGRectMake(0, 0, size.width, size.height);
//    return button;
//}
//
//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                              image:(NSString *)imageName
//                         titleColor:(UIColor *)titleColor
//                               font:(UIFont *)font
//                      directionType:(BtnImgDirectionType)type
//         contentHorizontalAlignment:(UIControlContentHorizontalAlignment)hAlign
//           contentVerticalAlignment:(UIControlContentVerticalAlignment)vAlign
//                  contentEdgeInsets:(UIEdgeInsets)contentEdge
//                               span:(CGFloat)span
//                             target:(id)target
//                             action:(SEL)action
//{
//    UIButton *button = [self createButtonWithTitle:title
//                                        titleColor:titleColor
//                                              font:font
//                                            target:target
//                                            action:action];
//
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    button.contentHorizontalAlignment = hAlign;
//    button.contentVerticalAlignment = vAlign;
//    button.contentEdgeInsets = contentEdge;
//
//    CGSize imageSize = button.imageView.frame.size;
//    CGSize titleSize = button.titleLabel.frame.size;
//    CGFloat totalWidth = (imageSize.width + titleSize.width) + span;
//    CGFloat totalHeight = (imageSize.height + titleSize.height) + span;
//
//    switch (type) {
//        case BtnImgDirectionDefault:
//        {
//            if (UIControlContentHorizontalAlignmentRight == hAlign) {
//                button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, span);
//            }else{
//                button.titleEdgeInsets = UIEdgeInsetsMake(0, span, 0, 0);
//            }
//        }
//            break;
//        case BtnImgDirectionRight:
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, (totalWidth - imageSize.width) , 0, -titleSize.width);
//            button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width , 0, (totalWidth - titleSize.width));
//            break;
//        case BtnImgDirectionTop:
//            button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0, 0, - titleSize.width);
//            button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height),0);
//            break;
//        case BtnImgDirectionBottom:
//            button.imageEdgeInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 0, 0, - titleSize.width);
//            button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, (totalHeight - titleSize.height),0);
//            break;
//    }
//    return button;
//}
//
//
////For UITextFiled
//+ (UITextField *)createTextFieldWithFont:(UIFont *)font
//                               textColor:(UIColor *)textColor
//                         backgroundColor:(UIColor *)backgroundColor
//                             borderStyle:(UITextBorderStyle)borderStyle
//                             placeholder:(NSString *)placeholder
//                                delegate:(id<UITextFieldDelegate>)delegate
//{
//    UITextField *textField = [[UITextField alloc] init];
//    textField.font = font;
//    textField.textColor = textColor;
//    textField.backgroundColor = backgroundColor;
//    textField.borderStyle = borderStyle;
//    textField.placeholder = placeholder;
//    textField.delegate = delegate;
//    return textField;
//}
//
//+ (UITextField *)createTextFieldWithLeftAttrTitle:(NSAttributedString *)aTitle
//                                             font:(UIFont *)font
//                                        textColor:(UIColor *)textColor
//                                  backgroundColor:(UIColor *)backgroundColor
//                                      placeholder:(NSString *)placeholder
//                                     keyboardType:(UIKeyboardType)keyboardType
//                                    returnKeyType:(UIReturnKeyType)returnKeyType
//                                         delegate:(id<UITextFieldDelegate>)delegate
//{
//    UITextField *textField = [self createTextFieldWithFont:font
//                                                 textColor:textColor
//                                           backgroundColor:backgroundColor
//                                               borderStyle:UITextBorderStyleNone
//                                               placeholder:placeholder
//                                                  delegate:delegate];
//    textField.keyboardType = keyboardType;
//    textField.returnKeyType = returnKeyType;
//
//    UILabel *label = [[UILabel alloc] init];
//    label.attributedText = aTitle;
//
//    textField.leftView = label;
//    textField.leftViewMode = UITextFieldViewModeAlways;
//
//    textField.enablesReturnKeyAutomatically = YES;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//
//    return textField;
//}
//
////For UITextView
//+ (UITextView *)createTextViewWithAttrString:(NSAttributedString *)aString
//                                  editEnable:(BOOL)eEnable
//                                scroolEnable:(BOOL)sEnable
//{
//    UITextView *textView = [[UITextView alloc] init];
//    if (aString) {
//        textView.attributedText = aString;
//    }
//    textView.editable = eEnable;
//    textView.scrollEnabled = sEnable;
//    return textView;
//}
//
//
////For UITableView
//+ (UITableView *)createTableWithStyle:(UITableViewStyle)style
//                   seporatorLineColor:(UIColor *)seporatorLineColor
//                           headerView:(UIView *)headerView
//                           footerView:(UIView *)footerView
//                           zeroMargin:(BOOL)zeroMargin
//                             delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate
//{
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
//    tableView.separatorColor = seporatorLineColor;
//    if (headerView) {
//        tableView.tableHeaderView = headerView;
//    }
//    if (footerView) {
//        tableView.tableFooterView = footerView;
//    }else{
//        tableView.tableFooterView = [[UIView alloc] init];
//    }
//    tableView.delegate = delegate;
//    tableView.dataSource = delegate;
//    if (zeroMargin) {
//        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]){
//            [tableView setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]){
//            [tableView setLayoutMargins:UIEdgeInsetsZero];
//        }
//    }
//    return tableView;
//}

//+ (UIWebView *)createWebViewWithUrl:(NSString *)webUrl
//                            baseURL:(NSURL *)baseUrl
//                         htmlString:(NSString *)htmlString
//                       scroolEnable:(BOOL)sEnable
//                           delegate:(id<UIWebViewDelegate>)delegate
//{
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.scrollView.scrollEnabled = sEnable;
//    webView.scrollView.showsHorizontalScrollIndicator = NO;
//    webView.scrollView.showsVerticalScrollIndicator = NO;
//    webView.delegate = delegate;
//    if (![StringTools isEmpty:webUrl]) {
//        NSURLRequest *request = [CommonNetTools getRequestWithURLString:webUrl method:@"GET" timeOut:45];
//        [webView loadRequest:request];
//    }
//
//    if (![StringTools isEmpty:htmlString]) {
//        [webView loadHTMLString:htmlString baseURL:baseUrl];
//    }
//
//    return webView;
//}

@end


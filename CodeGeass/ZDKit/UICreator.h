//
//  UICretator.h
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICreator : NSObject

#pragma mark - For UIView
+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor;
+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius;
+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
                    actionGesture:(UIGestureRecognizer *)gesture;
+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
                        tapAction:(void(^)())tapAction;

#pragma mark - For UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize;
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor;
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor;
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius;
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                    textAlignment:(NSTextAlignment)textAlignment
                         fontSize:(CGFloat)fontSize
                        textColor:(UIColor *)textColor
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
                        tapAction:(void(^)())tapAction;

#pragma mark - For UIButton
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                             action:(void(^)())action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                             action:(void(^)())action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                       cornerRadius:(CGFloat)cornerRadius
                             action:(void(^)())action;

#pragma mark - For UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName;
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                             cornerRadius:(CGFloat)cornerRadius;
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                             cornerRadius:(CGFloat)cornerRadius;
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                             cornerRadius:(CGFloat)cornerRadius
                            actionGesture:(UIGestureRecognizer *)gesture;
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                             cornerRadius:(CGFloat)cornerRadius
                                tapAction:(void(^)())tapAction;
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                              roundCorner:(BOOL)roundCorner
                                tapAction:(void(^)())tapAction;

#pragma mark ----------------------------------以上已重写，添加frame----------------------------------
#pragma mark - 

//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                         titleColor:(UIColor *)titleColor
//                               font:(UIFont *)font
//                             target:(id)target
//                             action:(SEL)action;
//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                         titleColor:(UIColor *)titleColor
//                               font:(UIFont *)font
//                         buttonType:(UIButtonType)buttonType
//                            bgColor:(UIColor *)bgColor
//                             corner:(float)cornerRadius
//                             target:(id)target
//                             action:(SEL)action;
//
//+ (UIButton *)createButtonWithTitle:(NSString *)title
//                              image:(NSString *)imageName
//                          titleEdge:(UIEdgeInsets)titleEdge
//                          imageEdge:(UIEdgeInsets)imageEdge
//                             target:(id)target
//                             action:(SEL)action;
//
//+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
//                         highlightedImage:(NSString *)highlightedImageName
//                                   target:(id)target
//                                   action:(SEL)action;
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
//                             action:(SEL)action;
//
//
//
////For UITextFiled
//+ (UITextField *)createTextFieldWithFont:(UIFont *)font
//                               textColor:(UIColor *)textColor
//                         backgroundColor:(UIColor *)backgroundColor
//                             borderStyle:(UITextBorderStyle)borderStyle
//                             placeholder:(NSString *)placeholder
//                                delegate:(id<UITextFieldDelegate>)delegate;
//
//+ (UITextField *)createTextFieldWithLeftAttrTitle:(NSAttributedString *)aTitle
//                                             font:(UIFont*)font
//                                        textColor:(UIColor*)textColor
//                                  backgroundColor:(UIColor*)backgroundColor
//                                      placeholder:(NSString*)placeholder
//                                     keyboardType:(UIKeyboardType)keyboardType
//                                    returnKeyType:(UIReturnKeyType)returnKeyType
//                                         delegate:(id<UITextFieldDelegate>)delegate;
//
//
////For UITextView
//+ (UITextView *)createTextViewWithAttrString:(NSAttributedString *)aString
//                                  editEnable:(BOOL)eEnable
//                                scroolEnable:(BOOL)sEnable;
//
//
////For UITableView
//+ (UITableView *)createTableWithStyle:(UITableViewStyle)style
//                   seporatorLineColor:(UIColor *)seporatorLineColor
//                           headerView:(UIView *)headerView
//                           footerView:(UIView *)footerView
//                           zeroMargin:(BOOL)zeroMargin
//                             delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;

//For UIWebView
//+ (UIWebView *)createWebViewWithUrl:(NSString *)webUrl
//                            baseURL:(NSURL *)baseUrl
//                         htmlString:(NSString *)htmlString
//                       scroolEnable:(BOOL)sEnable
//                           delegate:(id<UIWebViewDelegate>)delegate;


@end

//
//  BOAssistor.h
//
//  常用的辅助功能
//
//  Created by superjunjun on 2017/4/15.
//  Copyright © 2017年 superjunjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOAssistor : NSObject

//字符有效性验证
+ (BOOL)personNameIsValid:(NSString *)name;
+ (BOOL)usernameIsValid:(NSString *)username;
+ (BOOL)postCodeIsValid:(NSString *)postCode;
+ (BOOL)emailIsValid:(NSString *)email;
+ (BOOL)cellPhoneNumberIsValid:(NSString *)cellPhoneNumber;
+ (BOOL)phoneNumberIsValid:(NSString *)phoneNumber;
+ (BOOL)passwordLengthIsValid:(NSString *)password;//4~48
+ (BOOL)passwordIsValid:(NSString *)password;
+ (BOOL)emoveUserNickNameIsValid:(NSString *)nickName;
+ (BOOL)emoveUserSignatureIsValid:(NSString *)signature;
+ (NSString *)stringWithNilOrNull:(id)str;

//清理字符串
+ (NSString *)stringTrim:(NSString *)resStr;

//清理html字符串
+ (NSString *)filterHTML:(NSString *)html;

//获取规定font及width的空格字符串
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font;
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode;

//字符串中汉字数量
+ (NSUInteger)chineseCharactersLengthInString:(NSString *)string;

+ (NSArray *)appUrlSchemes;
+ (NSString *)appBundleShortVersion;
+ (NSString *)appBundleID;

//判定是否为图片地址
+ (BOOL)isImageFilePath:(NSString *)imagePath;

//设置为苹方字体
+ (UIFont *)defaultTextStringFontWithSize:(CGFloat)fontSize;
+ (UIFont *)mediumTextStringFontWithSize:(CGFloat)fontSize;

// 调用电话
+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;

//时间戳转时间
+ (NSString *)getTimeStringWithTimeStamp:(NSTimeInterval)time format:(NSString *)format;

/**
 获取验证码的定时器

 @param button 倒计时的button
 */
+ (void)timeChangeWithBtn:(UIButton *)button;

/**
 在退出vc 和结束进程 倒计时结束 的时候需要还原倒计时状态
 */
+ (void)setDefaultCountDownValue;

+ (UIViewController *)topViewController;
+ (UINavigationController *)topNavigationViewController;

@end

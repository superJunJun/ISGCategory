//
//  BOAssistor.m
//
//  常用的辅助功能
//
//  Created by superjunjun on 2017/4/15.
//  Copyright © 2017年 superjunjun. All rights reserved.
//

#import "BOAssistor.h"

#define currentDeviceSystemVersion            [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation BOAssistor

#pragma mark - Regular Expression

+ (BOOL)resourceString:(NSString *)resStr evalueWithPredicateRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:resStr];
}

+ (BOOL)personNameIsValid:(NSString *)name
{
    NSString *regex = @"^[\u4e00-\u9fa5]{2,15}$";
    return [self resourceString:name evalueWithPredicateRegex:regex];
}

+ (BOOL)postCodeIsValid:(NSString *)postCode
{
    NSString *regex = @"^[1-9]{1}(\\d+){5}$";
    return [self resourceString:postCode evalueWithPredicateRegex:regex];
}

+ (BOOL)cellPhoneNumberIsValid:(NSString *)cellPhoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    return [self resourceString:cellPhoneNumber evalueWithPredicateRegex:regex];
}

+ (BOOL)emailIsValid:(NSString *)email
{
    NSString *regex = @"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
    return [self resourceString:email evalueWithPredicateRegex:regex];
}

+ (BOOL)usernameIsValidLocalFunc:(NSString *)username
{
    NSString *regex = @"^[a-zA-Z|\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]{1,19}$";
    return [self resourceString:username evalueWithPredicateRegex:regex];
}

+ (BOOL)emoveUserNickNameIsValid:(NSString *)nickName
{
    if([self stringTrim:nickName].length > 0)
    {
        return (nickName.length >= 1 && nickName.length <= 15);
    }
    else
    {
        return NO;
    }
}

+ (BOOL)emoveUserSignatureIsValid:(NSString *)signature
{
    if([self stringTrim:signature].length > 0)
    {
        return signature.length <= 15;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)usernameIsValid:(NSString *)username
{
    //字符开头，限4-20字符，1个汉字为2个字符
    int finalLength = (int)[self chineseCharactersLengthInString:username];
    if(finalLength >= 4 && finalLength <= 20)
    {
        return [self usernameIsValidLocalFunc:username];
    }
    return NO;
}

+ (BOOL)phoneNumberIsValid:(NSString *)phoneNumber
{
//    NSString *regex = @"^(([1][3-8]\\d{9})|((\\d{3}-\\d{8})|(\\d{4}-\\d{7})))$";
//    return [self resourceString:phoneNumber evalueWithPredicateRegex:regex];
    return phoneNumber.length == 11;
}

+ (BOOL)passwordLengthIsValid:(NSString *)password
{
    //6~48
    return (password.length >= 6 && password.length <= 48);
}

+ (BOOL)passwordIsValid:(NSString *)password
{
    NSString *regex = @"[0-9a-zA-Z]{6,20}";
    return [self resourceString:password evalueWithPredicateRegex:regex];
}

+ (NSUInteger)chineseCharactersLengthInString:(NSString *)string
{
    NSUInteger len = string.length;
    // 汉字字符集
    NSString *pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return len + numMatch;
}

//@"/^[".chr(0xa1)."-".chr(0xff)."A-Za-z0-9_]+$/"   //GB2312汉字字母数字下划线正则表达式
//@"/^[/x{4e00}-/x{9fa5}A-Za-z0-9_]+$/u"            //UTF-8汉字字母数字下划线正则表达式
+ (NSString *)stringTrim:(NSString *)sourceString
{
    if (sourceString.length>1) {
        NSString *firstChar = [sourceString substringWithRange:NSMakeRange(0, 1)];
        if ([firstChar isEqualToString:@"<"]) {
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[sourceString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ,NSFontAttributeName : [BOAssistor defaultTextStringFontWithSize:13]} documentAttributes:nil error:nil];
            sourceString = [attrStr string];
        }
    }
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"+"];
    NSString *trimmedString = [sourceString stringByTrimmingCharactersInSet:set];
    NSString *trimmedString1 = [trimmedString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    NSString *trimmedString2 = [trimmedString1 stringByReplacingOccurrencesOfString:@"<br />" withString:@""];

    return trimmedString2;

}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    
    NSScanner * scanner2 = [NSScanner scannerWithString:html];
    NSString * text2 = nil;
    while([scanner2 isAtEnd]==NO)
    {
        [scanner2 scanUpToString:@"&" intoString:nil];
        [scanner2 scanUpToString:@";" intoString:&text2];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;",text2] withString:@""];
    }

    return html;
}

+ (BOOL)isImageFilePath:(NSString *)imagePath
{
    NSString *pathExtension = imagePath.pathExtension.lowercaseString;
    if([pathExtension isEqualToString:@"png"]
       || [pathExtension isEqualToString:@"jpg"]
       || [pathExtension isEqualToString:@"jpe"]
       || [pathExtension isEqualToString:@"jpeg"]
       || [pathExtension isEqualToString:@"gif"])
    {
        return YES;
    }
    return NO;
}

#pragma mark - Supported Font

+ (NSArray *)appUrlSchemes
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlDics = [info objectForKey:@"CFBundleURLTypes"];
    NSDictionary *urlDic = urlDics[0];
    NSArray *urlSchemes = [urlDic objectForKey:@"CFBundleURLSchemes"];;
    
    return urlSchemes;
}

+ (NSString *)appBundleShortVersion
{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return info[@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleID
{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return info[@"CFBundleIdentifier"];
}


+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font
{
    return [string sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode
{
    if(string.length == 0)
    {
        return CGSizeZero;
    }
    
    CGSize limitedSize = CGSizeMake(width, MAXFLOAT);
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        return [string boundingRectWithSize:limitedSize
                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil].size;
    }
    else
    {
        return CGSizeZero;
    }
}

#pragma mark - TimeInterval
+ (NSString *)getTimeStringWithTimeStamp:(NSTimeInterval)time format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

#pragma mark - LocalProvideFont
+ (UIFont *)defaultTextStringFontWithSize:(CGFloat)fontSize
{
    if (currentDeviceSystemVersion >= 9.0) {
       return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    }else{
       return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)mediumTextStringFontWithSize:(CGFloat)fontSize {
    if (currentDeviceSystemVersion >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    }else{
        return  [UIFont fontWithName:@"Helvetica-Bold" size:15];
    }
}

//数据是否为空
+ (NSString *)stringWithNilOrNull:(id)str
{
    if (str == nil || str == [NSNull null] ) {
        return @"";
    }
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqualToString:@"(null)"]) {
            return @"";
        }
    }
    return str;
}

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc {
    if (phoneStr.length >= 10) {
        NSString *str2 = [[UIDevice currentDevice] systemVersion];
        if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
        {
            NSString* PhoneStr = [NSString stringWithFormat:@"telprompt://%@",phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"phone success");
            }];
        }else {
            NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
            if (phoneStr.length == 10) {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
            }else {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
            }
            NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
            // 设置popover指向的item
            alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
            // 添加按钮
            [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                NSLog(@"点击了呼叫按钮10.2下");
                NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
                if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                        [app openURL:[NSURL URLWithString:PhoneStr]];
                    }
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }]];
            [selfvc presentViewController:alert animated:YES completion:nil];
        }
    }
}

+ (void)timeChangeWithBtn:(UIButton *)button {
    
    //退出到后台时继续走计时器
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(1) forKey:@"isBeginCountDown"];
    [userDefault synchronize];
    
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [button setTitle:@"重新发送" forState:UIControlStateNormal];
                button.titleLabel.font = [BOAssistor defaultTextStringFontWithSize:14];
                button.userInteractionEnabled = YES;
                
                [BOAssistor setDefaultCountDownValue];
            });
        }else {
            
            int second = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d",second];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@秒后可重新发送",strTime] forState:UIControlStateNormal];
                button.titleLabel.font = [BOAssistor defaultTextStringFontWithSize:12];
                button.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(timer);
}

+ (void)setDefaultCountDownValue {
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"isBeginCountDown"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 导航相关
+ (UIViewController *)topViewController {
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    return [self topViewControllerFromViewController:rootViewController];
}

+ (UINavigationController *)topNavigationViewController {
    if (![[self topViewController] navigationController]) {
        return [[UINavigationController alloc] initWithRootViewController:[self topViewController]];
    }
    return [[self topViewController] navigationController];
}

+ (UIViewController *)topViewControllerFromViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self topViewControllerFromViewController:[navigationController topViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self topViewControllerFromViewController:tabBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil && !viewController.presentedViewController.isBeingDismissed) {
        return [self topViewControllerFromViewController:viewController.presentedViewController];
    }
    return viewController;
}

#pragma mark -


@end

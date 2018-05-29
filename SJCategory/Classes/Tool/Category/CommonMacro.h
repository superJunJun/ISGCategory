//
//  CommonMacro.h
//  iShanggang
//
//  Created by 鲍晓飞 on 17/5/17.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//常用颜色
#define cCommonHeaderGrayColor   [UIColor colorWithHex:0xF8F8F8]
#define cCommonRedColor          [UIColor colorWithHex:0xD23023]
#define cCommonLineColor         cCommonRGBColor(229,229,229,1)
#define cCommonRGBColor(red,Green,Blue,Alpha) [UIColor colorWithRed:red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]
//屏幕
#define KSCREEWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define KSCREEWINDOW [[[UIApplication sharedApplication] delegate] window]
#define AdaptH(H) KSCREEWIDTH * H/375.0

//系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//app版本号
#define APPBundleShortVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//
#define isStrEmpty(_ref)  (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref)isEqualToString:@""]))

#endif /* CommonMacro_h */

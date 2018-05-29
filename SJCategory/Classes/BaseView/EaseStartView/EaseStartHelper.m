//
//  EaseStartHelper.m
//  ZMall
//
//  Created by  bxf on 2017/11/3.
//  Copyright © 2017年 lijun. All rights reserved.
//

#import "EaseStartHelper.h"
#import "EaseStartView.h"
#import "CommonMacro.h"

@interface EaseStartHelper ()

@property (nonatomic) UIWindow *rootWindow;
@property (nonatomic, strong) EaseStartView *startView;

@end

@implementation EaseStartHelper

+ (instancetype)shareInstance {
    static EaseStartHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[EaseStartHelper alloc] init];
    });
    
    return shareInstance;
}

+ (void)showStartView {
    [EaseStartHelper shareInstance].rootWindow = KSCREEWINDOW;
    
    [EaseStartHelper shareInstance].startView = [[EaseStartView alloc] initWithBgImage:[UIImage imageNamed:@"launchImage"]];
    [[EaseStartHelper shareInstance].rootWindow addSubview:[EaseStartHelper shareInstance].startView];
}

+ (void)dismissStartView {
    [UIView animateWithDuration:0.3 animations:^{
//        [EaseStartHelper shareInstance].startView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [EaseStartHelper shareInstance].startView.alpha = 0;
    } completion:^(BOOL finished) {
        [[EaseStartHelper shareInstance].startView removeFromSuperview];
    }];
    
}

@end

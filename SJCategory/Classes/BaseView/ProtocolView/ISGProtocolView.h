//
//  ISGProtocolView.h
//  iShanggang
//
//  Created by 鲍晓飞 on 17/5/27.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ProtocolClickBlock)();
typedef void (^RememberClickBlock)(BOOL isRemember);

@interface ISGProtocolView : UIView

// 协议view，格式为： 口 下一步同意《用户注册及相关协议》
@property (nonatomic, assign) BOOL isSelected; //是否同意
@property (nonatomic, copy) ProtocolClickBlock protocolClickBlock;
@property (nonatomic, copy) RememberClickBlock rememberClickBlock;

@property (nonatomic, strong) UIColor *leftStringColor;

- (instancetype)initWithLeftString:(NSString *)leftString agreeString:(NSString *)agressString;

@end

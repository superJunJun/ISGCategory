//
//  ISGProtocolView.m
//  iShanggang
//
//  Created by 鲍晓飞 on 17/5/27.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "ISGProtocolView.h"
#import "EnlargeAreaButton.h"
#import "UIViewExt.h"
#import "CommonMacro.h"

@interface ISGProtocolView()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation ISGProtocolView

- (instancetype)initWithLeftString:(NSString *)leftString agreeString:(NSString *)agreeString {
    if (self == [super init]) {
        UIButton *rememberPswBtn = [EnlargeAreaButton buttonWithType:UIButtonTypeCustom];
        rememberPswBtn.frame = CGRectMake(10, 0, 20, 20);
        [rememberPswBtn setImage:[UIImage imageNamed:@"BC_protocal_no_selected"] forState:UIControlStateNormal];
        [rememberPswBtn setImage:[UIImage imageNamed:@"BC_protocal_selected"] forState:UIControlStateSelected];
        rememberPswBtn.selected = YES;
        [rememberPswBtn addTarget:self action:@selector(remeberPswBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rememberPswBtn];
        
        _isSelected = YES;
        
        CGSize leftSize = [self getSizeWithString:leftString font:[UIFont systemFontOfSize:12]];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(rememberPswBtn.right+5, rememberPswBtn.top, leftSize.width, rememberPswBtn.height)];
        leftLabel.text = leftString;
        leftLabel.font = [UIFont systemFontOfSize:12];
        leftLabel.textColor = [UIColor colorWithHex:0x999999];
        [self addSubview:leftLabel];
        self.leftLabel = leftLabel;
        
        CGSize rightSize = [self getSizeWithString:agreeString font:[UIFont systemFontOfSize:12]];
        
        UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.right+5, rememberPswBtn.top, rightSize.width, rememberPswBtn.height)];
        agreeLabel.text = agreeString;
        agreeLabel.font = [UIFont systemFontOfSize:12];
        agreeLabel.textColor = [UIColor colorWithHex:0x00c3ac];
        [self addSubview:agreeLabel];
        self.rightLabel = agreeLabel;
        
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = agreeLabel.frame;
        [agreeBtn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:agreeBtn];
    }
    return self;
}

#pragma mark - private action
- (void)remeberPswBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        [sender setImage:[UIImage imageNamed:@"BC_protocal_no_selected"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"BC_protocal_selected"] forState:UIControlStateNormal];
    }
    
    _isSelected = sender.selected;
    
    if (self.rememberClickBlock) {
        self.rememberClickBlock(sender.selected);
    }
}

- (void)agreeClick {
    if (self.protocolClickBlock) {
        self.protocolClickBlock();
    }
}

#pragma mark - set/get
- (void)setLeftStringColor:(UIColor *)object {    
    _leftStringColor = object;
    
    _leftLabel.textColor = object;
}

- (CGSize)getSizeWithString:(NSString *)str font:(UIFont *)font {
    //高度随便写，要求尽量写大一点
    CGSize size = CGSizeMake(KSCREEWIDTH, 1000);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect frame = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size;
}



@end

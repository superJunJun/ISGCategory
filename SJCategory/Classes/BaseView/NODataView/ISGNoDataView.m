//
//  ISGNoDataView.m
//  iShanggang
//
//  Created by lijun on 2017/4/21.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "ISGNoDataView.h"
#import "CommonMacro.h"
#import "UIViewExt.h"
#import "UIColor+Hex.h"

@implementation ISGNoDataView

- (instancetype )initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self placeholderViewLoad];
    }
    return self;
}

- (void)placeholderViewLoad{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_empty"]];
    [imageView sizeToFit];
    imageView.center = CGPointMake(KSCREEWIDTH / 2.0, (KSCREENHEIGHT - 200) / 2.0);
    [self addSubview:imageView];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"这里什么都没有，您可以看看其他的...";
    label1.font = [BOAssistor defaultTextStringFontWithSize:13.0];
    label1.textColor = [UIColor colorWithHex:0x999999];
    [label1 sizeToFit];
    label1.top = imageView.bottom + 30;
    label1.xCenter = imageView.xCenter;
    [self addSubview:label1];
}
@end

//
//  EaseStartView.m
//  ZMall
//
//  Created by  bxf on 2017/11/3.
//  Copyright © 2017年 lijun. All rights reserved.
//

#import "EaseStartView.h"
#import "CommonMacro.h"

@interface EaseStartView ()

@property (strong, nonatomic) UIImageView *bgImageView;

@end

@implementation EaseStartView

+ (instancetype)startView {
    UIImage *bgImage = [UIImage imageNamed:@"launchImage"];
    return [[self alloc] initWithBgImage:bgImage];
}

- (instancetype)initWithBgImage:(UIImage *)bgImage {
    self = [super initWithFrame:CGRectMake(0, 0, KSCREEWIDTH, KSCREENHEIGHT)];
    if (self) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREEWIDTH, KSCREENHEIGHT)];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = bgImage;
        [self addSubview:_bgImageView];
    }
    return self;
}


@end

//
//  BONoticeBar.m
//
//  单行文字弹出提示条
//

#import "BONoticeBar.h"
#import "UIViewExt.h"
#import "UIColor+Hex.h"

#define nNoticeTextBarHoldDuration      2.0f

//BONoticeTextView

typedef NS_ENUM(NSInteger, BONoticeTextViewStatus)
{
    BONoticeTextViewStatusNone = 0,
    BONoticeTextViewStatusShowing,
    BONoticeTextViewStatusShowComplete,
    BONoticeTextViewStatusHiding,
    BONoticeTextViewStatusHideComplete
};

@class BONoticeTextView;
@protocol BONoticeTextViewDelegate <NSObject>
@required
- (void)noticeTextViewHideActionComplete:(BONoticeTextView *)view;
@end

@interface BONoticeTextView : UIView

@property (nonatomic) BONoticeTextViewStatus status;
@property (nonatomic) CGPoint centerPoint;
@property (strong, nonatomic) NSTimer *hideTimer;
//interface
@property (nonatomic) BOOL shouldHideImmediately;
@property (assign, nonatomic) id<BONoticeTextViewDelegate> delegate;
- (instancetype)initWithNoticeText:(NSString *)noticeText
                             style:(BONoticeBarStyle)style
                            center:(CGPoint)center;
- (void)noticeTextBarShow;
- (void)noticeTextBarHide;

@end

@implementation BONoticeTextView

- (instancetype)initWithNoticeText:(NSString *)noticeText
                             style:(BONoticeBarStyle)style
                            center:(CGPoint)center
{
    if(self = [super init])
    {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.shouldHideImmediately = NO;
        self.status = BONoticeTextViewStatusNone;
        self.centerPoint = center;
        NSInteger labelCapW = 100;
        NSInteger labelCapH = 20;
        
        UIFont *textFont = [UIFont systemFontOfSize:16];
        UIColor *textColor = [UIColor whiteColor];
        UIColor *bgViewShadowColor = [UIColor blackColor];
        if(style == BONoticeBarStyleWhite)
        {
            textColor = [UIColor blackColor];
            bgViewShadowColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        }
        
        UILabel *textLabel = [UILabel new];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = textFont;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = textColor;
        textLabel.text = noticeText;
        [textLabel sizeToFit];
        if (textLabel.width > 300) {
            
            CGSize limitedSize = CGSizeMake(300, MAXFLOAT);
            if([noticeText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
            {
                textLabel.size = [noticeText boundingRectWithSize:limitedSize
                                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                       attributes:@{NSFontAttributeName:textFont}
                                                          context:nil].size;
            }
            labelCapW = 60;
        }
        textLabel.origin = CGPointMake(labelCapW/2, labelCapH/2);//6 4
        [self addSubview:textLabel];
        
        CGRect frame = CGRectMake(0, 0, textLabel.width + labelCapW, textLabel.height + labelCapH);//11 8
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        bgView.backgroundColor = bgViewShadowColor;
        bgView.layer.cornerRadius = 4;
        bgView.layer.shadowOffset = CGSizeMake(3, 3);
        bgView.layer.shadowOpacity = 0.9;
        bgView.layer.shadowRadius = 1.0;
        bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        bgView.alpha = 0.7;////
        [self insertSubview:bgView belowSubview:textLabel];
        
        self.frame = frame;
    }
    return self;
}

#pragma mark - OverrideSettingMethod

- (void)setShouldHideImmediately:(BOOL)shouldHideImmediately
{
    _shouldHideImmediately = shouldHideImmediately;
    if(shouldHideImmediately)
    {
        if(self.status != BONoticeTextViewStatusHiding
           && self.status != BONoticeTextViewStatusHideComplete)
        {
            self.status = BONoticeTextViewStatusHiding;
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(noticeTextBarHide) userInfo:nil repeats:NO];
        }
    }
}

#pragma mark - VisibleAction

- (void)hideTimerCancel
{
    if([self.hideTimer isValid])
    {
        [self.hideTimer invalidate];
        self.hideTimer = nil;
    }
}

- (void)noticeTextBarHide
{
    [self hideTimerCancel];
    self.status = BONoticeTextViewStatusHiding;
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.35 animations:^{
        wself.alpha = 0;
    }completion:^(BOOL finished) {
        if(finished)
        {
            self.status = BONoticeTextViewStatusHideComplete;
            [wself.delegate noticeTextViewHideActionComplete:wself];
        }
    }];
}

- (void)noticeTextBarShow
{
    [self hideTimerCancel];
    self.alpha = 0;
    self.status = BONoticeTextViewStatusShowing;
    self.hideTimer = [NSTimer scheduledTimerWithTimeInterval:nNoticeTextBarHoldDuration target:self selector:@selector(noticeTextBarHide) userInfo:nil repeats:NO];
    [self.superview bringSubviewToFront:self];
    [self appendShowAnimation];
}

- (void)appendShowAnimation
{
    self.alpha = 1;
    CGPoint aimPoint = self.centerPoint;
    CGFloat yCenter0 = aimPoint.y + 80;
    CGFloat yCenter1 = aimPoint.y - 10;
    CGFloat yCenter2 = aimPoint.y + 4;
    CGFloat yCenter3 = aimPoint.y;
    CGFloat xCenter = aimPoint.x;
    
    CGFloat duration0 = 0.2;
    CGFloat duration1 = 0.1;
    CGFloat duration2 = 0.1;
    CGFloat duration = duration0 + duration1 + duration2;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    //时间的变化曲线
    //positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //创建路径信息，开始点 － 最远点 － 最近点 － 结束点
    positionAnimation.duration = duration;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, xCenter, yCenter0);
    CGPathAddLineToPoint(path, NULL, xCenter, yCenter1);
    CGPathAddLineToPoint(path, NULL, xCenter, yCenter2);
    CGPathAddLineToPoint(path, NULL, xCenter, yCenter3);
    positionAnimation.path = path;
    CGPathRelease(path);
    positionAnimation.keyTimes = @[@(0.0), @(duration0 / duration), @((duration0 + duration1) / duration), @(1.0)];
    //    positionAnimation.delegate = self;
    [self.layer addAnimation:positionAnimation forKey:@"layerAnimation"];
    
    self.center = aimPoint;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        self.status = BONoticeTextViewStatusShowComplete;
        if(self.shouldHideImmediately)
        {
            self.shouldHideImmediately = YES;
        }
    }
}

@end

//BONoticeBar
@interface BONoticeBar () <BONoticeTextViewDelegate>

@property (strong, nonatomic) NSMutableArray *noticeTextViews;
@property (weak, nonatomic) UIView *masterView;

@end

@implementation BONoticeBar

+ (instancetype)defaultBar
{
    static BONoticeBar *defaultBarInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        defaultBarInstance = [[self alloc] init];
    });
    return defaultBarInstance;
}

- (instancetype)init
{
    if(self = [super init])
    {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        self.masterView = window;
        self.noticeTextViews = [NSMutableArray new];
        self.centerPoint = CGPointMake(self.masterView.innerCenter.x, self.masterView.height/2);
    }
    return self;
}

- (void)noticeTextViewsAppendOneView:(BONoticeTextView *)view
{
    for(BONoticeTextView *noticeTextView in self.noticeTextViews)
    {
        noticeTextView.shouldHideImmediately = YES;
    }
    [self.noticeTextViews addObject:view];
}

#pragma mark - BONoticeTextViewDelegate

- (void)noticeTextViewHideActionComplete:(BONoticeTextView *)view
{
    [view removeFromSuperview];
    [self.noticeTextViews removeObject:view];
}

#pragma mark - OverrideSettingMethod

- (void)setNoticeText:(NSString *)noticeText
{
    _noticeText = noticeText;
    if(noticeText.length > 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            BONoticeTextView *noticeTextView = [[BONoticeTextView alloc] initWithNoticeText:noticeText style:self.style center:self.centerPoint];
            [self.masterView addSubview:noticeTextView];
            [self noticeTextViewsAppendOneView:noticeTextView];
            [noticeTextView noticeTextBarShow];
        });
    }
}

@end

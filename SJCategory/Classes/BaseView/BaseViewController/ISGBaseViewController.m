//
//  BaseViewController.m
//

#import "ISGBaseViewController.h"
#import "BOHUDManager.h"
#import "BONoticeBar.h"
#import "UIColor+Hex.h"

@interface ISGBaseViewController ()

@property (strong, nonatomic) BOHUDManager *hudManager;
@property (strong, nonatomic) BONoticeBar *noticeBar;
@property (nonatomic, strong) UIView *noDataView;
@end

@implementation ISGBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    
    [self localInfosInitialize];
    
    //解决iOS11：UITableView列表出现错位；页面切换过程中出现抖动问题
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:sNetworkState object:nil];
}

- (void)localInfosInitialize
{
    self.customEdgesForExtendedLayout = UIRectEdgeNone;
    self.hudManager = [BOHUDManager defaultManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - NSNotification

- (void)netWorkStateChange:(NSNotification *)noti{
    
    NSLog(@"开始重新加载网络");
}

#pragma mark - OverridePropertyMethod

- (void)setCustomEdgesForExtendedLayout:(UIRectEdge)customEdgesForExtendedLayout
{
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = customEdgesForExtendedLayout;
        _customEdgesForExtendedLayout = customEdgesForExtendedLayout;
    }
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.navigationItem.title = titleText;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[BOAssistor defaultTextStringFontWithSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


#pragma mark - HUD

- (void)progressHUDShowWithText:(NSString *)text
{
    [self.hudManager progressHUDShowWithText:text];
}

- (void)progressHUDShowWithCompleteText:(NSString *)text isSucceed:(BOOL)isSucceed
{
    [self.hudManager progressHUDShowWithCompleteText:text isSucceed:isSucceed];
}

- (void)progressHUDMomentaryShowWithTarget:(id)target action:(SEL)action object:(id)object
{
    [self.hudManager progressHUDMomentaryShowWithTarget:target action:action object:object];
}

- (void)progressHUDMomentaryShowWithText:(NSString *)text target:(id)target action:(SEL)action object:(id)object
{
    [self.hudManager progressHUDMomentaryShowWithText:text target:target action:action object:object];
}

- (void)progressHUDShowWithCompleteText:(NSString *)text isSucceed:(BOOL)isSucceed additionalTarget:(id)target action:(SEL)action object:(id)object
{
    [self.hudManager progressHUDShowWithCompleteText:text isSucceed:isSucceed additionalTarget:target action:action object:object];
}

- (void)progressHUDHideImmediately
{
    [self.hudManager progressHUDHideImmediately];
}

- (void)loadDataErrorText:(NSString *)errorString {
    if ([ASGNetWorkEngine networkConnectionIsAvailable]) {
        [self.hudManager progressHUDShowWithCompleteText:errorString isSucceed:NO];
    }
}

#pragma mark - NoticeBar

- (BONoticeBar *)noticeBar
{
    if(!_noticeBar)
    {
        _noticeBar = [BONoticeBar defaultBar];
    }
    return _noticeBar;
}

- (void)setNoticeText:(NSString *)noticeText
{
    self.noticeBar.noticeText = noticeText;
}

- (void)setNoticeBarCenter:(CGPoint)noticeBarCenter
{
    self.noticeBar.centerPoint = noticeBarCenter;
}

- (void)setIsNoticeStyleBlack:(BOOL)isNoticeStyleBlack
{
    self.noticeBar.style = isNoticeStyleBlack ? BONoticeBarStyleBlack : BONoticeBarStyleWhite;
}

#pragma mark - URLRequest

- (void)postRequestWithURL:(NSString *)url
                sessionID:(BOOL )sessionID
             HUDLabelText:(NSString *)text
                   params:(NSDictionary *)params
            completeBlock:(AMPostHttpRequestCompletionBlock)completeBlock
              failedBlock:(AMPostHttpRequestFailedBlock)failedBlock{
    if (text.length) {
        [self progressHUDShowWithText:text];
    }
    
    [ASGNetWorkEngine postRequestWithURL:url sessionID:sessionID params:params completeBlock:^(NSDictionary *result) {
        [self requestSuccessWithResult:result completeBlock:completeBlock];
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

- (void)postRequestWithURL:(NSString *)url
                 sessionID:(BOOL )sessionID
              HUDLabelText:(NSString *)text
            paramsIsInBody:(BOOL)paramsIsInBody
                    params:(NSDictionary *)params
             completeBlock:(AMPostHttpRequestCompletionBlock)completeBlock
               failedBlock:(AMPostHttpRequestFailedBlock)failedBlock{
    if (text.length) {
        [self progressHUDShowWithText:text];
    }
    
    [ASGNetWorkEngine postRequestWithURL:url sessionID:sessionID paramIsInBody:paramsIsInBody params:params completeBlock:^(NSDictionary *result) {
        
        [self requestSuccessWithResult:result completeBlock:completeBlock];
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

- (void)getRequestWithURL:(NSString *)url
                sessionID:(BOOL )sessionID
             HUDLabelText:(NSString *)text
                   params:(NSDictionary *)params
            completeBlock:(AMPostHttpRequestCompletionBlock)completeBlock
              failedBlock:(AMPostHttpRequestFailedBlock)failedBlock {
    if (text.length) {
        [self progressHUDShowWithText:text];
    }
    
    [ASGNetWorkEngine getRequestWithURL:url sessionID:sessionID params:params completeBlock:^(NSDictionary *result) {
        
        [self requestSuccessWithResult:result completeBlock:completeBlock];
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

- (void)requestSuccessWithResult:(NSDictionary *)result completeBlock:(AMPostHttpRequestCompletionBlock)completeBlock {
    if ([result[@"status"]integerValue] == 200) {
        [self progressHUDHideImmediately];
        
        [self setNoticeText:@"登录过期，请重新登录"];
        
        [[ISGUserInfo sharedUserInfo] logout];
        
        UIViewController * vc = [ZMTransMediator loginViewController];
        UINavigationController *nav = [[ISGBaseNavigationController alloc] initWithRootViewController:vc];
        KSCREEWINDOW.rootViewController = nav;
        
    } else {
        completeBlock(result);
    }
}

#pragma mark - 工具方法
- (void)ISG_NavigationBarWithTitle:(NSString *)title {
    self.navigationItem.title = title;
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"p_backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(p_customBackNavigationBarButtonAction)];
    backBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

- (void)ISG_NavigationBarWithTitle:(NSString *)title leftImageNamed:(NSString *)leftImageName andAction:(SEL)action {
    
    //这个title是用来设置导航左返回按钮标题的，这里暂时没用。
    if (leftImageName == nil) {
        leftImageName = @"p_backArrow";
    }
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:leftImageName] style:UIBarButtonItemStylePlain target:self action:action];
    backBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

- (void)ISG_NavigationRightBarWithTitle:(NSString *)title andAction:(nullable SEL)action {
    UIFont *titleFont = [BOAssistor defaultTextStringFontWithSize:16];
    CGSize strSize = [title boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    CGFloat width = strSize.width+55;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 0, width, 30.0f);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = titleFont;
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)p_customBackNavigationBarButtonAction {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ISG_update_dataRefreshByScrollview:(UIScrollView *)scroll target:(nullable id)target action:(SEL)action isAutomaticallyRefreshing:(BOOL)isBegining{
    
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
    //设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    //马上进入刷新状态
    if(isBegining)
        [header beginRefreshing];
    
    // 设置header
    scroll.mj_header = header;
    scroll.mj_header.automaticallyChangeAlpha = YES;
}

- (void)ISG_more_dataRefreshByScrollview:(nonnull UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action {
    
    //添加默认的上拉刷新
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:action];
    //MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:action];
//设置文字
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    footer.refreshingTitleHidden = YES;
    footer.automaticallyHidden = YES;
    //设置footer
    scroll.mj_footer = footer;
}

- (void)ISG_no_dataRefreshByScrollView:(nonnull UIScrollView *)scroll {
    
    MJRefreshAutoNormalFooter * footer = (MJRefreshAutoNormalFooter*)(scroll.mj_footer);
//    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    [footer endRefreshingWithNoMoreData];
}

- (void)ISG_resetRefreshByScrollView:(nonnull UIScrollView *)scroll {
    MJRefreshAutoNormalFooter * footer = (MJRefreshAutoNormalFooter*)(scroll.mj_footer);
    [footer resetNoMoreData];
}

@end

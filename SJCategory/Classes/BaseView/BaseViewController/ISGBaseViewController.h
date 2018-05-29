//
//  BaseViewController.h
//

#import <UIKit/UIKit.h>

@interface ISGBaseViewController : UIViewController

@property (nonatomic, assign) UIRectEdge customEdgesForExtendedLayout;
@property (nonatomic, copy, nullable) NSString *titleText;
@property (nonatomic, assign) CGPoint noticeBarCenter;
@property (nonatomic, assign) BOOL isNoticeStyleBlack;
@property (nonatomic, copy, nullable) NSString *noticeText;

- (void)progressHUDShowWithText:(nullable NSString *)text;
- (void)progressHUDShowWithCompleteText:(nullable NSString *)text isSucceed:(BOOL)isSucceed;
- (void)progressHUDMomentaryShowWithTarget:(nullable id)target action:(nullable SEL)action object:(nullable id)object;
- (void)progressHUDMomentaryShowWithText:(nullable NSString *)text target:(nullable id)target action:(nullable SEL)action object:(nullable id)object;
- (void)progressHUDShowWithCompleteText:(nullable NSString *)text isSucceed:(BOOL)isSucceed additionalTarget:(nullable nullable id)target action:(nullable SEL)action object:(nullable id)object;
- (void)progressHUDHideImmediately;
- (void)loadDataErrorText:(nullable NSString *)errorString;


#pragma mark - barbuttonItem
- (void)ISG_NavigationBarWithTitle:(nullable NSString *)title;
- (void)ISG_NavigationBarWithTitle:(nullable NSString *)title leftImageNamed:(nullable NSString *)leftImageName andAction:(nullable SEL)action;
- (void)ISG_NavigationRightBarWithTitle:(nullable NSString *)title andAction:(nullable SEL)action;


#pragma mark - Refresh
- (void)ISG_update_dataRefreshByScrollview:(nonnull UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action isAutomaticallyRefreshing:(BOOL)isBegining;
- (void)ISG_more_dataRefreshByScrollview:(nonnull UIScrollView *)scroll target:(nullable id)target action:(nullable SEL)action;
- (void)ISG_no_dataRefreshByScrollView:(nonnull UIScrollView *)scroll;
- (void)ISG_resetRefreshByScrollView:(nonnull UIScrollView *)scroll;

- (void)netWorkStateChange:(NSNotification *_Nullable)noti;

@end

/*!
 *  名称：XYSPageController
 *
 *  作用：通过滑动操作，展示视图
 *
 *  支持：布局需要Masonry支持(https://github.com/SnapKit/Masonry)
 *
 *  Create by XYS 2016/10/01
 */

#import <UIKit/UIKit.h>
#import "Masonry.h"

/** 滑动方向 */
typedef NS_ENUM(NSInteger, XYSPageControllerScrollDirection)
{
    /** 向左滑动（向上滑动）*/
    XYSPageControllerScrollDirectionLeft = 0,
    /** 向右滑动（向下滑动）*/
    XYSPageControllerScrollDirectionRight = 1
};
/** 滑动风格 */
typedef NS_ENUM(NSInteger, XYSPageControllerScrollStyle)
{
    /** 水平方向 */
    XYSPageControllerScrollStyleHorizontal = 0,
    /** 竖直方向 */
    XYSPageControllerScrollStyleVertical = 1
};

@interface XYSPageController : UIViewController
/**
 *  工厂模式创建对象
 *
 *  @param viewController 当前页面显示的视图控制器
 *  @param style          滑动风格(水平、竖直)
 */
+ (instancetype)pageWithCurrentViewController:(UIViewController *)viewController
                              scrollStyle:(XYSPageControllerScrollStyle)style;
/**
 *  手动设置当前页面显示的控制器视图
 *
 *  @param viewController 显示的控制器视图
 *  @param direction      滑动出现的方向
 *  @param animated       是否显示滑动动画
 */
- (void)setCurrentViewController:(UIViewController *)viewController
                       direction:(XYSPageControllerScrollDirection)direction
                        animated:(BOOL)animated;
/** 展示分页视图的滑动视图 */
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
/** 当前可见页面中的控制器视图*/
@property (nonatomic, strong, readonly) UIViewController *currentViewController;
/** 滑动风格 */
@property (nonatomic, assign, readonly) XYSPageControllerScrollStyle scrollStyle;
/** 边缘弹性设置，默认NO */
@property (nonatomic, assign, getter=isBounces) BOOL bounces;

#pragma mark - 注意：请在本类提供的（didLoadLeftViewController、didLoadRightViewController）方法中设置以下属性(属性返回nil时代表不循环)
/** 当前页面显示的控制器视图左边(上边)的控制器视图 */
@property (nonatomic, strong) UIViewController *rightViewController;
/** 当前页面显示的控制器视图右边(下边)的控制器视图 */
@property (nonatomic, strong) UIViewController *leftViewController;

@end


#pragma mark - 委托用户操作的回调代码

typedef void(^LeftScrollHandler)(UIViewController *currentViewController);
typedef void(^RightScrollHandler)(UIViewController *currentViewController);
typedef void(^HandlerForDidCompleteScroll)(UIViewController *currentViewController);
typedef void(^HandlerForWillStartDrag)(UIViewController *currentViewController);
typedef void(^HandlerForDidEndDrag)(UIViewController *currentViewController);

@interface XYSPageController ()

@property (nonatomic, strong) LeftScrollHandler leftScrollHandler; //记录向左滑动的回调代码
@property (nonatomic, strong) RightScrollHandler rightScrollHandler; //记录向右滑动的回调代码
@property (nonatomic, strong) HandlerForDidCompleteScroll didCompleteScroll; //记录滑动完全结束时的回调代码
@property (nonatomic, strong) HandlerForWillStartDrag willDrag; //记录用户即将drag时的回调代码
@property (nonatomic, strong) HandlerForDidEndDrag didEndDrag; //记录用户结束drag时的回调代码

/** 用户在该代码块中，设置左侧的控制器视图 */
- (void)didLoadLeftViewController:(RightScrollHandler)handler;
/** 用户在该代码块中，设置右侧的控制器视图 */
- (void)didLoadRightViewController:(LeftScrollHandler)handler;

/** 滑动完全结束的事件回调操作*/
- (void)handlerForDidCompleteScroll:(HandlerForDidCompleteScroll)handler;
/** 用户即将drag的事件回调操作 */
- (void)handlerForWillStartDrag:(HandlerForWillStartDrag)handler;
/** 用户结束drag的事件回调操作 */
- (void)handlerForDidEndDrag:(HandlerForDidEndDrag)handler;

@end

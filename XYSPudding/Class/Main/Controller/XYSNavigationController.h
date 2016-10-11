/**
 *    名称：XYSNavigationController
 *
 *    作用：自定义导航栏，配置导航栏参数。
 *
 *    目的：快速使用配置好的导航栏。
 */

#import <UIKit/UIKit.h>

@class XYSTabBarDataModel;

@interface XYSNavigationController : UINavigationController

/**
 *  工厂模式创建导航栏对象
 *
 *  @param rootViewController 传入根视图控制器
 *
 */
+ (instancetype)navigationWithRootViewController:(UIViewController *)rootViewController;

@end

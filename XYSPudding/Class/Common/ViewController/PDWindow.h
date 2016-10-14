/**
 *  自制window, 用于界面中间位置显示控制器视图
 */

#import <UIKit/UIKit.h>

@interface PDWindow : UIViewController

/** 多线程单例模式创建窗口对象 */
+ (id)standardWindow;

/** 接收传入的根视图控制器 */
@property (nonatomic, strong) UIViewController *rootViewController;

/** 释放窗口对象 */
- (void)dismiss:(BOOL)animated;

@end

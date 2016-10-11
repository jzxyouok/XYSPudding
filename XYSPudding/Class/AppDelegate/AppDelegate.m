#import "AppDelegate.h"
#import "AppDelegate+Launch.h"
#import "XYSTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/** 配置APP启动项 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeWithApplication:application]; //配置默认参数
    self.window.rootViewController = [XYSTabBarController new];
    
    return YES;
}

/** 设置APP休眠前的操作 */
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

/** 设置APP后台服务项 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

/** 设置APP进入前台运行之前的操作 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

/** 设置APP活跃时的操作 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

/** 设置APP终止之前的操作 */
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

/** 配置APP主窗口 */
- (UIWindow *)window
{
    if (!_window)
    {
        _window = [UIWindow viewWithFrame:kScreenBounds];
        [_window setBackgroundColor:[UIColor whiteColor]];
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end
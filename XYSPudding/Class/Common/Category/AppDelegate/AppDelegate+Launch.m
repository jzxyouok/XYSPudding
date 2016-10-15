#import "AppDelegate+Launch.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSObject+Factory.h"


/** 记录wifi状态下是否联网 */
static NSNumber *isOnlineWifi = nil;

@implementation AppDelegate (Launch)

#pragma mark - app启动的初始化设置

/** app启动时的初始化设置 */
- (void)initializeWithApplication:(UIApplication *)application
{
    [self didRegisterSDK]; //注册第三方SDK
    [self detectNetwork]; //实时监测网络
}

#pragma mark - 首次启动、版本更新配置

/** 首次启动、版本更新时加载的信息 */
- (void)didLoadDataWhenFirstLaunchOrReleaseNewVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary]; //获取info.plist文件
    NSString *version = infoDic[@"CFBundleShortVersionString"]; //获取版本号
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersion"]; //获取本地缓存的版本号
    
    if (![version isEqualToString:oldVersion]) //首次使用APP或更新版时加载引导界面，反之进入主界面
    {
        [[NSUserDefaults standardUserDefaults] setValue:version forKey:@"oldVersion"]; //更新本地缓存
    }
}

#pragma Mark - 网络

/** 监测网络*/
- (void)detectNetwork
{
    /** 数据传输时状态栏显示网络活动指示器 */
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    /** 监测当前的网络状态 */
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
        DDLogVerbose(@"当前网络状态: %@", AFStringFromNetworkReachabilityStatus(status));
         switch (status)
         {
             case AFNetworkReachabilityStatusReachableViaWWAN: //手机内部网络
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi: //可用wifi
                 isOnlineWifi = [NSNumber numberWithBool:YES];
                 break;
             case AFNetworkReachabilityStatusNotReachable: //无网络
                 [self showAlertForDisconnectNetwork]; //提示框
                 break;
             case AFNetworkReachabilityStatusUnknown: //未知网络
                 break;
             default:
                 break;
         }
     }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring]; //开启网络监测
}

/** 获取当前网络状态类型 */
+ (NSString *)getCurrentNetworkState
{
    id statusBar = [[UIApplication sharedApplication] valueForKeyPath:@"statusBar"]; //获取状态栏对象
    id statusBarForegroundView = [statusBar valueForKeyPath:@"foregroundView"]; //获取状态栏前景视图
    NSArray *statusBarChildrenView = [statusBarForegroundView subviews]; //获取状态栏前景视图的子视图
    
    NSString *state = nil; //记录网络状态信息
    
    /** 遍历状态栏前景视图的子视图，获取网络标签视图对象 */
    for (id childView in statusBarChildrenView)
    {
        if ([childView isKindOfClass: NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            switch ([[childView valueForKeyPath:@"dataNetworkType"] intValue])
            {
                case 0:
                    state = @"无网络";
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                    if (!isOnlineWifi)
                    {
                        state =  @"未知网络状态的wifi";
                    }
                    else if ([isOnlineWifi boolValue])
                    {
                        state =  @"wifi";
                    }
                    else
                    {
                        state =  @"无网络的wifi";
                    }
                    break;
                default:
                    break;
            }
        }
    }
    return state;
}

#pragma mark - 第三方SDK的注册使用

/** 注册第三方SDK */
- (void)didRegisterSDK
{
    /** 注册DDLog取代NSLog */
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

/** 全局横屏设置 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application
  supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscape;
}

@end

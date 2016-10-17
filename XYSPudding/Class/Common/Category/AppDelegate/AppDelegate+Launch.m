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
    /** 实时监测网络 */
    [self detectNetwork];
    /** 推送服务 */
    [self didRegisterPushServiceWithApplication:application];
    /** 注册第三方SDK */
    [self didRegisterSDK];
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

#pragma mark - 推送服务

/** 注册推送服务 */
- (void)didRegisterPushServiceWithApplication:(UIApplication *)application
{
    /** 推送服务ios8特殊处理 */
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
                                                                                           UIUserNotificationTypeBadge |
                                                                                           UIUserNotificationTypeSound
                                                                                categories:nil];
        [application registerUserNotificationSettings:setting];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|
         UIRemoteNotificationTypeBadge|UIUserNotificationTypeSound];
#pragma clang diagnostic pop
    }
    
    /** 本地推送 */
    UILocalNotification *localNotification = [UILocalNotification new];
    [localNotification setAlertTitle:@"布丁娘"];
    [localNotification setAlertBody:@"更新提醒"];
    [localNotification setUserInfo:@{@"push" : @"推送"}];
    /** 小于30s的声音文件名名称 */
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    /** 触发时间(10s后触发) */
    [localNotification setFireDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
    /** 推送消息的未读数目 */
    [localNotification setApplicationIconBadgeNumber:100];
    /** 注册 */
    [application scheduleLocalNotification:localNotification];
    
    /** 消除未读数目 */
    [application setApplicationIconBadgeNumber:0];
}

/** 接收苹果回传的推送验证信息 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DDLogInfo(@"苹果远程推送验证信息");
}

/** 接收远程推送消息 */
- (void)         application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}
/** 接收本地推送消息 */
- (void)        application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    DDLogInfo(@"%@", notification);
}
/** 证书错误、模拟器调试等会导致注册失败 */
- (void)                             application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DDLogInfo(@"未注册证书，无法远程推送");
}

@end

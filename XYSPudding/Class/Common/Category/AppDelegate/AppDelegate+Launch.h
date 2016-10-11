#import "AppDelegate.h"

@interface AppDelegate (Launch)

/*!
 *  设置app启动的默认参数
 *
 *  @param application app对象
 */
- (void)initializeWithApplication:(UIApplication *)application;

/*!
 *  获取当前网络类型
 *
 *  @return 描述性字符串;
 */
+ (NSString *)getCurrentNetworkState;

@end

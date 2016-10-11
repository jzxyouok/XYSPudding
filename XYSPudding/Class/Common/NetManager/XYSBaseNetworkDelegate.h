/*!
 *  简单的数据加载协议
 *
 *  Created by XYS on 16/9/1
 */

#import <Foundation/Foundation.h>
/*!
 *  数据加载方式枚举
 */
typedef NS_ENUM(NSInteger, XYSDataLoadType)
{
    /** 刷新页面数据 */
    XYSDataLoadTypeNew = 1,
    /** 加载更多页面数据 */
    XYSDataLoadTypeMore = 0
};

@protocol XYSBaseNetworkDelegate <NSObject>
@optional
/*!
 *  多方式的网络数据加载
 *
 *  @param loadType             数据加载方式
 *  @param userInfo             存储附加信息（变化的请求参数、其他信息）
 *  @param completionHandler    回调操作（回传模型对象）
 */
+ (id)loadDataWithloadType:(XYSDataLoadType)loadType
                  userInfo:(NSDictionary *)userInfo
         completionHandler:(void(^)(id model, NSDictionary *userInfo, NSError *error))completionHandler;
/*!
 *  多方式的网络数据加载
 *
 *  @param userInfo             存储附加信息（数据加载方式、变化的请求参数、其他信息）
 *  @param completionHandler    回调操作
 */
+ (id)loadDataWithUserInfo:(NSDictionary *)userInfo
         completionHandler:(void(^)(id model, NSDictionary *userInfo, NSError *error))completionHandler;
/*!
 *  单一的网络数据加载
 *
 *  @param completionHandler 回调操作（回传模型对象）
 */
+ (id)loadDataWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
/*!
 *  本地数据加载
 *
 *  @param completionHandler 回调操作（回传模型对象）
 */
+ (void)loadLocalDataWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end

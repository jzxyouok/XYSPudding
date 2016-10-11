/*!
 *  简单的数据请求基类
 *
 *  本类需要AFNetworking类库支持
 *
 *  Created by XYS on 16/9/1
 */

#import <UIKit/UIKit.h>
#import "XYSBaseNetworkDelegate.h"

@interface XYSBaseNetwork : NSObject<XYSBaseNetworkDelegate>

/*!
 *  NSURLSessionDataTask方式请求网络数据
 *
 *  @param path               网络请求地址
 *  @param params             网络请求参数
 *  @param completionHandler  加载结束后的操作
 *
 */
+ (id)    getPath:(NSString *)path
       parameters:(NSDictionary *)params
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler;

/*!
 *  AFNetworking方式Get请求网络数据
 *
 *  @param path               网络请求地址
 *  @param params             网络请求参数
 *  @param timeout            网络请求限时
 *  @param completionHandler  加载结束后的操作
 *
 */
+ (id)   getPathA:(NSString *)path
       parameters:(NSDictionary *)params
          timeout:(NSTimeInterval)timeout
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler;
/*!
 *  AFNetworking方式Post请求网络数据
 *
 *  @param path               网络请求地址
 *  @param params             网络请求参数
 *  @param timeout            网络请求限时
 *  @param completionHandler  加载结束后的操作
 *
 */
+ (id)  postPathA:(NSString *)path
       parameters:(NSDictionary *)params
          timeout:(NSTimeInterval)timeout
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler;

/*!
 *  请求本地数据
 *
 *  @param path              本地路径
 *  @param completionHandler 结束请求后的操作
 *
 */
+ (void)getLocalPath:(NSString *)path
   completionHandler:(void(^)(id responseObject, NSError *error))completionHandler;

@end

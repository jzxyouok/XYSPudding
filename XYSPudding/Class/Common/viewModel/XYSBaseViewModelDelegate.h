/*!
 * 简单的model对象数据获取协议
 *
 *  Created by XYS on 16/9/1
 */

#import <Foundation/Foundation.h>
#import "XYSBaseNetworkDelegate.h"

@protocol XYSBaseViewModelDelegate <NSObject>
@optional

#pragma mark - 数据获取方式1
/*!
 *  获取当前页面的模型对象数据
 *
 *  @param loadType          数据获取方式
 *  @param completionHandler 回调操作
 *
 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType
          completionHandler:(void(^)(NSError *error))completionHandler;

#pragma mark - 数据获取方式2
/*!
 *  获取页面模型对象数据
 */
- (void)getDataWithCompletionHandler:(void(^)(NSError *error))completionHandler;
/*!
 *  刷新当前页面的模型对象数据
 */
- (void)refreshDataWithCompletionHandler:(void(^)(NSError *error))completionHandler;
/*!
 *  获取更多当前页面的模型对象数据
 */
- (void)getMoreDataWithCompletionHandler:(void(^)(NSError *error))completionHandler;
@end



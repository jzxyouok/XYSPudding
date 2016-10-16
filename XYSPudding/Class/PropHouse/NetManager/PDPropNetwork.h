//
//  PDPropNetwork.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseNetwork.h"

@interface PDPropNetwork : XYSBaseNetwork

/** 加载请求参数信息 */
+ (id)loadParametersDataWithCompletionHandler:(void (^)(id model, NSError *error))completionHandler;


/** 加载分类商品数据 */
+ (id)loadCatogryGoodsDataWithParameters:(NSDictionary *)params
                       CompletionHandler:(void (^)(id model, NSError *error))completionHandler;

/** 加载列表商品数据 */
+ (id)loadListGoodsDataWithParameters:(NSDictionary *)params
                    CompletionHandler:(void (^)(id model, NSError *error))completionHandler;

@end

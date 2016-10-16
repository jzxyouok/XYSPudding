//
//  PDPropNetwork.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPropNetwork.h"
#import "PDPropGroodsListModel.h"

@implementation PDPropNetwork

/** 加载请求参数信息 */
+ (id)loadParametersDataWithCompletionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v2/coupon/available_count";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"model"] = model_;
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPathA:baseURL
              parameters:params
                  timeout:10
       completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDPropGroodsListModel parse:responseObject], error);
            }];
}


/** 加载分类商品数据 */
+ (id)loadCatogryGoodsDataWithParameters:(NSDictionary *)params
                       CompletionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v2/goods_category";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"apiKey"] = apiKey_;
    parameters[@"auth1"] = auth1_;
    parameters[@"brand"] = brand_;
    parameters[@"channelId"] = channelId_;
    parameters[@"deviceKey"] = deviceKey_;
    parameters[@"model"] = model_;
    parameters[@"os"] = os_;
    parameters[@"osv"] = osv_;
    parameters[@"timestamp"] = timestamp_;
    parameters[@"version"] = version_;
    
    return [self getPathA:baseURL
               parameters:params
                  timeout:10
        completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDPropGroodsListModel parse:responseObject], error);
            }];
}

/** 加载列表商品数据 */
+ (id)loadListGoodsDataWithParameters:(NSDictionary *)params
                    CompletionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v2/goods/recommend";
       
    return [self getPathA:baseURL
               parameters:params
                  timeout:10
        completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDPropGroodsListModel parse:responseObject], error);
            }];
}
@end

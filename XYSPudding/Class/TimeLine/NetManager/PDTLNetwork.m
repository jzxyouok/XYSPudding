//
//  PDTLNetwork.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTLNetwork.h"
#import "PDTLTopicModel.h"

@implementation PDTLNetwork

/** 加载数据 */
+ (id)loadDataWithloadType:(XYSDataLoadType)loadType userInfo:(NSDictionary *)userInfo completionHandler:(void (^)(id model, NSDictionary *userInfo, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/activity/popular";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"limit"] = @20;
    params[@"model"] = model_;
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    if (loadType == XYSDataLoadTypeMore)
    {
        params[@"offset"] = userInfo[@"offset"];
    }
    params[@"timestamp"] = timestamp_;
    params[@"types"] = @"10001%2C10002%2C10009%2C10010%2C10011";
    params[@"version"] = version_;
    
    return [self getPathA:baseURL
               parameters:params
                  timeout:10
        completionHandler:^(id responseObject, NSError *error)
    {
        completionHandler([PDTLTopicModel parse:responseObject], nil, error);
    }];
}
@end

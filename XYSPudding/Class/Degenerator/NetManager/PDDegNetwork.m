//
//  PDDegNetwork.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegNetwork.h"
#import "PDDegGroupModel.h"
#import "PDDegImageListModel.h"
#import "PDDegGroupDetailModel.h"
#import "PDDegGroupTopicListModel.h"

/** 加载分组数据 */
@implementation PDDegNetwork

/** 加载小组列表数据 */
+ (id)loadGroupListDataWithLimit:(NSInteger)limit
                          offset:(NSInteger)offset
               CompletionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/discovery/recommended_group";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"limit"] = @(limit);
    params[@"model"] = model_;
    if (offset > 0)
    {
        params[@"offset"] = @(offset);
    }
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPathA:baseURL
               parameters:params
                  timeout:10
        completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDDegGroupModel parse:responseObject], error);
            }];
}

/** 加载图片列表数据 */
+ (id)loadImageListDataWithloadType:(XYSDataLoadType)loadType
                           userInfo:(NSDictionary *)userInfo
                  completionHandler:(void (^)(id model, NSDictionary *userInfo, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/picture";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"model"] = model_;
    if (loadType == XYSDataLoadTypeMore)
    {
        params[@"offset"] = @20;
    }
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"sort"] = sort_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPath:baseURL
              parameters:params
       completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDDegImageListModel parse:responseObject], nil, error);
            }];
}

/** 加载小组详情数据 */
+ (id)loadGroupDetailDataWithID:(NSString *)id_
              completionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/group/";
    baseURL = [baseURL stringByAppendingString:id_];
    
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
    
    return [self getPath:baseURL
              parameters:params
       completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDDegGroupDetailModel parse:responseObject], error);
            }];
}

/** 加载小组主题列表数据 */
+ (id)loadGroupTopicListDataWithID:(NSString *)id_
                 completionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/group/";
    baseURL = [baseURL stringByAppendingString:id_];
    baseURL = [baseURL stringByAppendingString:@"/topic"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"limit"] = @(20);
    params[@"model"] = model_;
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"sort"] = sort2_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPath:baseURL
              parameters:params
       completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDDegGroupTopicListModel parse:responseObject], error);
            }];
}

@end

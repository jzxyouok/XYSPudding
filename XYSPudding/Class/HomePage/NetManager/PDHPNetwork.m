//
//  PDHPNetwork.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHPNetwork.h"
#import "PDAnimeGroupListModel.h"
#import "PDHPGroupModel.h"
#import "PDReceiveModel.h"
#import "PDHPLatestModel.h"

@implementation PDHPNetwork

/** 加载分组数据 */
+ (id)loadAnimGroupDataWithOffset:(NSInteger)offset
                          groupStryle:(PDHPGroupStyle)style
                    completionHandler:(void (^)(id model,
                                                NSError *error))completionHandler
{
    NSString *baseURL = nil;
    NSInteger limit = 0;
    switch (style)
    {
            /** 番组推荐 */
        case PDHPGroupStyleRecommend:
        {
            baseURL = @"http://pudding.cc/api/v2/anime/recommended_ep";
            limit = 4;
            break;
        }
            /** 最近更新 */
        case PDHPGroupStyleLatest:
        {
            baseURL = @"http://pudding.cc/api/v2/anime/non_china_latest_ep";
            limit = 4;
            break;
        }
            /** 国产动画 */
        case PDHPGroupStyleDomesticAnimation:
        {
            baseURL = @"http://pudding.cc/api/v2/anime/studio_related";
            limit = 4;
            break;
        }
            /** 完结推荐 */
        case PDHPGroupStyleEndRecommend:
        {
            baseURL = @"http://pudding.cc/api/v1/anime/recommended";
            limit = 4;
            break;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"limit"] = @(limit);
    params[@"model"] = model_;
    if (offset != 0)
    {
        params[@"offset"] = @(offset);
    }
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPath:baseURL
              parameters:params
       completionHandler:^(id responseObject, NSError *error)
            {
                if (style == PDHPGroupStyleLatest)
                {
                    completionHandler([PDHPLatestModel parse:responseObject], error);
                }
                else if (style == PDHPGroupStyleEndRecommend)
                {
                    completionHandler([PDAnimeModel parse:responseObject], error);
                }
                else
                {
                    completionHandler([PDHPGroupModel parse:responseObject], error);
                }
            }];
}


/** 加载首页展示的分组动画列表数据 */
+ (id)loadAnimGroupListDataWithOffset:(NSInteger)offset
                    completionHandler:(void (^)(id model, NSError *error))completionHandler
{
    NSString *baseURL = @"http://pudding.cc/api/v1/album/recommended";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"apiKey"] = apiKey_;
    params[@"auth1"] = auth1_;
    params[@"brand"] = brand_;
    params[@"channelId"] = channelId_;
    params[@"deviceKey"] = deviceKey_;
    params[@"itemCount"] = @4;
    params[@"limit"] = @20;
    params[@"model"] = model_;
    params[@"offset"] = @(offset);
    params[@"os"] = os_;
    params[@"osv"] = osv_;
    params[@"timestamp"] = timestamp_;
    params[@"version"] = version_;
    
    return [self getPath:baseURL
              parameters:params
       completionHandler:^(id responseObject, NSError *error)
            {
                completionHandler([PDAnimeGroupListModel parse:responseObject], error);
            }];
}

@end

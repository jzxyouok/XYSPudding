//
//  PDDegNetwork.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseNetwork.h"

@interface PDDegNetwork : XYSBaseNetwork

/** 加载小组列表数据 */
+ (id)loadGroupListDataWithLimit:(NSInteger)limit
                      offset:(NSInteger)offset
           CompletionHandler:(void (^)(id model, NSError *error))completionHandler;

/** 加载图片列表数据 */
+ (id)loadImageListDataWithloadType:(XYSDataLoadType)loadType
                           userInfo:(NSDictionary *)userInfo
                  completionHandler:(void (^)(id model, NSDictionary *userInfo, NSError *error))completionHandler;

/** 加载小组详情数据 */
+ (id)loadGroupDetailDataWithID:(NSString *)id_
              completionHandler:(void (^)(id model, NSError *error))completionHandler;

/** 加载小组主题列表数据 */
+ (id)loadGroupTopicListDataWithID:(NSString *)id_
              completionHandler:(void (^)(id model, NSError *error))completionHandler;

@end

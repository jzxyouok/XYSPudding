//
//  PDDegNetwork.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseNetwork.h"

@interface PDDegNetwork : XYSBaseNetwork

/** 加载分组数据 */
+ (id)loadGroupDataWithCompletionHandler:(void (^)(id model, NSError *error))completionHandler;

/** 加载图片列表数据 */
+ (id)loadImageListDataWithloadType:(XYSDataLoadType)loadType
                           userInfo:(NSDictionary *)userInfo
                  completionHandler:(void (^)(id model, NSDictionary *userInfo, NSError *error))completionHandler;

@end

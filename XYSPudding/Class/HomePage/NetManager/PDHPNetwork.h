//
//  PDHPNetwork.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseNetwork.h"


typedef NS_ENUM(NSInteger, PDHPGroupStyle)
{
    /** 番组推荐 */
    PDHPGroupStyleRecommend,
    /** 最近更新 */
    PDHPGroupStyleLatest,
    /** 国产动画 */
    PDHPGroupStyleDomesticAnimation,
    /** 完结推荐 */
    PDHPGroupStyleEndRecommend,
};

@interface PDHPNetwork : XYSBaseNetwork

/** 加载分组数据 */
+ (id)loadAnimGroupDataWithOffset:(NSInteger)offset
                      groupStryle:(PDHPGroupStyle)style
                completionHandler:(void (^)(id model, NSError *error))completionHandler;


/** 加载首页展示的分组动画列表数据 */
+ (id)loadAnimGroupListDataWithOffset:(NSInteger)offset
                    completionHandler:(void (^)(id model, NSError *error))completionHandler;

@end

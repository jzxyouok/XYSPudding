//
//  PDResultModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"
#import "PDAnimeModel.h"

@class PDResultModel, PDGoodsModel, PDEpsModel;

/** 接收的数据模型 */
@interface PDReceiveModel : XYSBaseModel

/** 数据请求参数 */
@property (nonatomic, strong) NSDictionary *parameters;
/** 错误编码 */
@property (nonatomic, assign) NSInteger errorCode;
/** 结果模型 */
@property (nonatomic, strong) PDResultModel *result;
/** 错误信息 */
@property (nonatomic, copy) NSString *errorMessage;

@end

/** 结果数据模型 */
@interface PDResultModel : XYSBaseModel

/** 反馈信息 */
@property (nonatomic, copy) NSString *message;
/** 数目 */
@property (nonatomic, assign) NSInteger total;
/** 商品结果列表 */
@property (nonatomic, strong) NSArray<PDGoodsModel *> *goodsList;
/** 国产动画结果列表 */
@property (nonatomic, strong) NSArray<PDAnimeModel *> *animeList;
/** 最近更新动画结果列表 */
@property (nonatomic, strong) NSArray<PDEpsModel *> *epsList;

@end
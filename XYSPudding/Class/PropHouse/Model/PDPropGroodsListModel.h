//
//  PDPropCatogryModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"

@class PDPropGroodsListResultModel,PDPropGroodsListResultListModel,PDImageModel;

#pragma mark - 第一层

@interface PDPropGroodsListModel : XYSBaseModel

/** 数据请求参数 */
@property (nonatomic, strong) NSDictionary *parameters;
/** 错误编码 */
@property (nonatomic, assign) NSInteger errorCode;
/** 请求数据结果存储数组 */
@property (nonatomic, strong) PDPropGroodsListResultModel *result;
/** 错误信息 */
@property (nonatomic, copy) NSString *errorMessage;

@end

#pragma mark - 第二层

/**
 *  商品结果数据模型
 */
@interface PDPropGroodsListResultModel : XYSBaseModel
/** 反馈信息 */
@property (nonatomic, copy) NSString *message;
/** 结果数目 */
@property (nonatomic, assign) NSInteger total;
/** 结果列表 */
@property (nonatomic, strong) NSArray<PDPropGroodsListResultListModel *> *list;

@end

#pragma mark - 第三层

/**
 *  存储商品信息模型
 */
@interface PDPropGroodsListResultListModel : XYSBaseModel

/** 状态码 */
@property (nonatomic, assign) NSInteger status;
/** 等级排名 */
@property (nonatomic, assign) NSInteger rank;
/** id标识 */
@property (nonatomic, copy) NSString *_id;
/** 展示图片模型对象 */
@property (nonatomic, strong) PDImageModel *image;
/** ios专用图片模型对象 */
@property (nonatomic, strong) PDImageModel *iosImage;
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 描述信息 */
@property (nonatomic, copy) NSString *description_;
/** 商品标签（new、hot） */
@property (nonatomic, copy) NSString *label;
/** 方形图片模型 */
@property (nonatomic, strong) PDImageModel *square;
/** 商品链接地址 */
@property (nonatomic, copy) NSString *url;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 16进制颜色数据 */
@property (nonatomic, copy) NSString *color;
/** 价格 */
@property (nonatomic, assign) NSInteger price;
/** 浏览人数 */
@property (nonatomic, assign) NSInteger viewCount;
/** 相关id标识 */
@property (nonatomic, copy) NSString *relatedId;
/** 相关类型 */
@property (nonatomic, assign) NSInteger relatedType;

@end

/** 展示图片模型对象 */
@interface PDImageModel : XYSBaseModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;

@end


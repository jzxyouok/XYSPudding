//
//  PDPropCatogryModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDReceiveModel.h"
#import "PDImageModel.h"

@interface PDPropGroodsListModel : PDReceiveModel

@end


/** 商品模型 */
@interface PDGoodsModel : XYSBaseModel

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


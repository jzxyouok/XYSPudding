//
//  PDDegGroupModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"
#import "PDImageModel.h"

@interface PDDegGroupModel : XYSBaseModel

/** 分组标识 */
@property (nonatomic, copy) NSString *_id;
/** 分组发布的总主题数目 */
@property (nonatomic, assign) NSInteger topicCount;
/** 分组成员数目 */
@property (nonatomic, assign) NSInteger memberCount;
/** 数据状态码 */
@property (nonatomic, assign) NSInteger status;
/** 分组信息描述 */
@property (nonatomic, copy) NSString *intro;
/** 异次元分组详情背景图模型对象 */
@property (nonatomic, strong) PDImageModel *background;
/** 分组中今日发布的主题数目 */
@property (nonatomic, assign) NSInteger todayTopicCount;
/** 分组名称 */
@property (nonatomic, copy) NSString *name;
/** 异次元分组展示图片模型对象 */
@property (nonatomic, strong) PDImageModel *icon;

@end


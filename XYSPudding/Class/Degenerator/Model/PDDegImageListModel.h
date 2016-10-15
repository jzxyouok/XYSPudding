//
//  PDDegImageModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"
#import "PDUserModel.h"

@class PDDegImageListImageModel;

#pragma mark - 第一层

/**
 *  图片主题模型
 */
@interface PDDegImageListModel : XYSBaseModel

/** 数据状态标识 */
@property (nonatomic, assign) NSInteger status;
/** 图片主题发布时间 */
@property (nonatomic, assign) NSInteger insertedTime;
/** 图片主题最后评论时间 */
@property (nonatomic, assign) NSInteger lastCommentedTime;
/** 图片主题被收藏的数目 */
@property (nonatomic, assign) NSInteger voteCount;
/** 主题标识 */
@property (nonatomic, copy) NSString *_id;
/** 火热程度指标参数 */
@property (nonatomic, assign) CGFloat hot;
/** 图片主题是否是被收藏的 */
@property (nonatomic, assign) BOOL voted;
/** 图片主题发布的用户id标识 */
@property (nonatomic, copy) NSString *userId;
/** 评论数目 */
@property (nonatomic, assign) NSInteger replyCount;
/** 标题内容 */
@property (nonatomic, copy) NSString *content;
/** 图片模型对象 */
@property (nonatomic, strong) PDDegImageListImageModel *image;
/** 图片主题发布的用户模型对象 */
@property (nonatomic, strong) PDUserModel *user;

@property (nonatomic, assign) NSInteger boardCount;
//@property (nonatomic, strong) NSArray<> *tagRelations;
//@property (nonatomic, strong) NSArray<> *animes;

@end

#pragma mark - 第二层

/**
 *  主题中的图片模型
 */
@interface PDDegImageListImageModel : XYSBaseModel
/** 是否是Gif图片 */
@property (nonatomic, assign) BOOL isGif;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片网络地址 */
@property (nonatomic, copy) NSString *url;

@end


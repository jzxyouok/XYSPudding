//
//  PDDegImageModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"

@class PDDegImageImageModel, PDDegImageUserModel, PDDegImageUserAvatarModel, PDDegImageUserBackgroundModel;

#pragma mark - 第一层

/**
 *  图片主题模型
 */
@interface PDDegImageModel : XYSBaseModel

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
@property (nonatomic, strong) PDDegImageImageModel *image;
/** 图片主题发布的用户模型对象 */
@property (nonatomic, strong) PDDegImageUserModel *user;

@property (nonatomic, assign) NSInteger boardCount;
//@property (nonatomic, strong) NSArray<> *tagRelations;
//@property (nonatomic, strong) NSArray<> *animes;

@end

#pragma mark - 第二层

/**
 *  主题中的图片模型
 */
@interface PDDegImageImageModel : XYSBaseModel
/** 是否是Gif图片 */
@property (nonatomic, assign) BOOL isGif;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片网络地址 */
@property (nonatomic, copy) NSString *url;

@end

/**
 *  发布主题的用户模型
 */
@interface PDDegImageUserModel : XYSBaseModel

@property (nonatomic, assign) CGFloat coinCount;

@property (nonatomic, assign) BOOL strangerChatEnabled;

@property (nonatomic, assign) NSInteger followingCount;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger picCount;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) NSInteger epCount;

@property (nonatomic, assign) NSInteger topicCount;

@property (nonatomic, assign) NSInteger followingBoardCount;

@property (nonatomic, assign) BOOL blocked;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL isAdmin;

@property (nonatomic, assign) NSInteger audioCount;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, assign) BOOL rongCloudActivated;

@property (nonatomic, assign) NSInteger followerCount;

@property (nonatomic, assign) NSInteger epPlayCount;

@property (nonatomic, assign) NSInteger boardCount;

@property (nonatomic, strong) PDDegImageUserAvatarModel *avatar;

@property (nonatomic, strong) PDDegImageUserBackgroundModel *background;

//@property (nonatomic, strong) NSArray *authorities;
//
//@property (nonatomic, strong) NSArray *roles;
//
//@property (nonatomic, strong) NSArray *roleIntro;
//
//@property (nonatomic, strong) NSArray *authorityDes;

@end

#pragma mark - 第三层

/** 用户头像模型 */
@interface PDDegImageUserAvatarModel : XYSBaseModel

@property (nonatomic, copy) NSString *url;

@end

/** 用户主题详情背景图模型 */
@interface PDDegImageUserBackgroundModel : XYSBaseModel

@property (nonatomic, copy) NSString *url;

@end


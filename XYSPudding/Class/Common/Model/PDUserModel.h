/**
 *  用户模型
 */

#import "XYSBaseModel.h"

@class PDAvatarModel, PDBackgroundModel;

#pragma mark - 第一层

/**
 *  用户模型
 */
@interface PDUserModel : XYSBaseModel

/** 头像模型 */
@property (nonatomic, strong) PDAvatarModel *avatar;
/** 信息展示详情背景图模型 */
@property (nonatomic, strong) PDBackgroundModel *background;
/** 授权信息数组 */
@property (nonatomic, strong) NSArray *authorities;
/** 个人简介 */
@property (nonatomic, copy) NSString *intro;
/** 硬币数目 */
@property (nonatomic, assign) CGFloat coinCount;
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 图片数目 */
@property (nonatomic, assign) NSInteger picCount;
/** 发布的主题数目 */
@property (nonatomic, assign) NSInteger topicCount;
/** 评论数目 */
@property (nonatomic, assign) NSInteger commentCount;
/** id标识 */
@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) NSInteger epCount;

@property (nonatomic, assign) NSInteger followingBoardCount;

@property (nonatomic, assign) BOOL blocked;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL isAdmin;

@property (nonatomic, assign) NSInteger audioCount;

@property (nonatomic, assign) BOOL rongCloudActivated;

@property (nonatomic, assign) NSInteger followerCount;

@property (nonatomic, assign) NSInteger epPlayCount;

@property (nonatomic, assign) NSInteger boardCount;

@property (nonatomic, strong) NSArray *roles;

@property (nonatomic, strong) NSArray *roleIntro;

@property (nonatomic, strong) NSArray *authorityDes;

@property (nonatomic, assign) BOOL strangerChatEnabled;

@property (nonatomic, assign) NSInteger followingCount;

@end

#pragma mark - 第二层

/**
 *  用户头像模型
 */
@interface PDAvatarModel : XYSBaseModel

/** 头像url地址 */
@property (nonatomic, copy) NSString *url;

@end

/**
 *  信息展示背景图模型
 */
@interface PDBackgroundModel : XYSBaseModel

/** 背景图url地址 */
@property (nonatomic, copy) NSString *url;

@end

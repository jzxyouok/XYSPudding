/**
 *  用户模型
 */

#import "XYSBaseModel.h"
#import "PDImageModel.h"

@interface PDUserModel : XYSBaseModel

/** 头像模型 */
@property (nonatomic, strong) PDImageModel *avatar;
/** 信息展示详情背景图模型 */
@property (nonatomic, strong) PDImageModel *background;
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

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, strong) PDImageModel *icon;

@end

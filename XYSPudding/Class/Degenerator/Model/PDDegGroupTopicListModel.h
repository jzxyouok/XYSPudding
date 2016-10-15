/**
 *  小组主题列表视图模型
 */

#import "XYSBaseModel.h"
#import "PDUserModel.h"

@class PDDegGroupTopicListActivityModel, PDDegGroupTopicListImagesModel;

@interface PDDegGroupTopicListModel : XYSBaseModel

/** 最后一次回复时间 */
@property (nonatomic, assign) NSInteger replyTime;
/** 状态码 */
@property (nonatomic, assign) NSInteger status;
/** 用户模型 */
@property (nonatomic, strong) PDUserModel *user;
/** 插入该主题的时间 */
@property (nonatomic, assign) NSInteger insertedTime;
/** 收藏数目 */
@property (nonatomic, assign) NSInteger voteCount;
/** 标识 */
@property (nonatomic, copy) NSString *_id;
/** 活动标识 */
@property (nonatomic, copy) NSString *activityId;
/** 火热程度系数 */
@property (nonatomic, assign) CGFloat hot;
/** 活动模型 */
@property (nonatomic, strong) PDDegGroupTopicListActivityModel *activity;
/** 图片模型 */
@property (nonatomic, strong) NSArray<PDDegGroupTopicListImagesModel *> *images;
/** 回复数目 */
@property (nonatomic, assign) NSInteger replyCount;
/** 文本内容 */
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL stick;
/** 是否被关注 */
@property (nonatomic, assign) BOOL selected;

@end


@interface PDDegGroupTopicListActivityModel : XYSBaseModel

/** 标识 */
@property (nonatomic, copy) NSString *_id;
/** 回复数目 */
@property (nonatomic, assign) NSInteger replyCount;
/** 转发数目 */
@property (nonatomic, assign) NSInteger repostCount;
/** 数据状态 */
@property (nonatomic, assign) NSInteger status;
/** 发布时间 */
@property (nonatomic, assign) NSInteger postedTime;
/** 主题类型 */ //10002
@property (nonatomic, assign) NSInteger type;
/** 收藏数目 */
@property (nonatomic, assign) NSInteger voteCount;

@end

@interface PDDegGroupTopicListImagesModel : XYSBaseModel

/** 图片url地址 */
@property (nonatomic, copy) NSString *url;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;

@end


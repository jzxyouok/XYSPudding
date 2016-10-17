/**
 *  小组数据模型
 */

#import "XYSBaseModel.h"
#import "PDUserModel.h"

#pragma mark - 第一层

@interface PDDegGroupDetailModel : XYSBaseModel
/** 小组简介 */
@property (nonatomic, copy) NSString *intro;
/** 成员数目 */
@property (nonatomic, assign) NSInteger memberCount;
/** 标识 */
@property (nonatomic, copy) NSString *_id;
/** 总话题数目 */
@property (nonatomic, assign) NSInteger topicCount;
/** 小组组长信息模型 */
@property (nonatomic, strong) PDUserModel *creator;
/** 小组图标 */
@property (nonatomic, strong) PDImageModel *icon;
/** 今日话题数目 */
@property (nonatomic, assign) NSInteger todayTopicCount;
/** 用户是否加入该小组 */
@property (nonatomic, assign) BOOL joined;
/** 小组副组长信息模型 */
@property (nonatomic, strong) NSArray<PDUserModel *> *viceOwners;
/** 小组昵称 */
@property (nonatomic, copy) NSString *name;
/** 数据状态 */
@property (nonatomic, assign) NSInteger status;

//@property (nonatomic, strong) PDBackgroundModel *background;
//@property (nonatomic, strong) NSArray *administrators;

@end

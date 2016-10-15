/**
 *  分组详情页面的头部视图上展示的小组基本信息的视图模型
 */
#import "XYSBaseViewModel.h"

@interface PDDegGroupDetailViewModel : XYSBaseViewModel

/** 传入小组id，通过id来实现数据获取 */
- (instancetype)initWithGrupID:(NSString *)id_;
@property (nonatomic, strong, readonly) NSString *id_;

/** 图标 */
- (NSURL *)iconURL;
/** 成员数目 */
- (NSInteger)numberOfMembers;
/** 今日主题数目 */
- (NSInteger)numberOfTodatTopics;
/** 组长名称 */
- (NSString *)creatorName;
/** 副组长名称 */
- (NSArray<NSString *> *)viceOwnerNames;

@end

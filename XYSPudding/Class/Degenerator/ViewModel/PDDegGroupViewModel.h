/**
 *  展示小组信息的视图模型
 */

#import "XYSBaseViewModel.h"

@interface PDDegGroupViewModel : XYSBaseViewModel

/** 单例 */
+ (id)defaultGroupViewModel;
/** 刷新数据 */
- (void)refreshDataWithGrupStyle:(NSInteger)style
               CompletionHandler:(void (^)(NSError *error))completionHandler;


/** 分组数目 */
@property (nonatomic, assign) NSInteger groupNumber;
/** 分组展示图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index;
/** 分组名称 */
- (NSString *)nameWithIndex:(NSInteger)index;

/** 分组详情展示背景图URL */
- (NSURL *)backgroundImageURLWithIndex:(NSInteger)index;

/** 小组成员数目 */
- (NSString *)memberCountWithIndex:(NSInteger)index;
/** 今日主题数目 */
- (NSString *)todayTopicCountWithIndex:(NSInteger)index;


@end

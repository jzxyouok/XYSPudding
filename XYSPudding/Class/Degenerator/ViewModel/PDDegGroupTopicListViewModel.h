/**
 *  小组主题列表视图模型
 */

#import "XYSBaseViewModel.h"

@interface PDDegGroupTopicListViewModel : XYSBaseViewModel

/** 通过传入的id获取请求数据 */
- (instancetype)initWithID:(NSString *)id_;
@property (nonatomic, strong, readonly) NSString *id_;

/** 主题数目 */
@property (nonatomic, assign) NSInteger listNumber;
/** 头像url */
- (NSURL *)avatarURLWithIndex:(NSInteger)index;
/** 昵称 */
- (NSString *)nickNameWithIndex:(NSInteger)index;
/** 发布时间 */
- (NSString *)presentTimeWithIndex:(NSInteger)index;
/** 文本内容 */
- (NSString *)contentWithIndex:(NSInteger)index;
/** 是否被关注 */
- (BOOL)isConcernedWithIndex:(NSInteger)index;

/** 是否包含图片 */
- (BOOL)isContainImageWithIndex:(NSInteger)index;
/** 图片数目 */
- (NSInteger)imageNumberWithIndex:(NSInteger)index;
/** 图片url地址 */
- (NSURL *)imageURLWithRowIndex:(NSInteger)rIndex imageIndex:(NSInteger)iIndex;

/** 转发数目 */
- (NSInteger)repostCountWithIndex:(NSInteger)index;
/** 点赞数目 */
- (NSInteger)praiseCountWithIndex:(NSInteger)index;
/** 回复数目 */
- (NSInteger)replyCountWithIndex:(NSInteger)index;

@end

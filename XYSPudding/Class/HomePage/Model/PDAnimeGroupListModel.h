/**
 *  动漫分组块列表模型
 */

#import "XYSBaseModel.h"
#import "PDImageModel.h"
#import "PDAnimeModel.h"

@class Itemcount,Items;

@interface PDAnimeGroupListModel : XYSBaseModel

/** 标识id */
@property (nonatomic, copy) NSString *_id;
/** 小组标题 */
@property (nonatomic, copy) NSString *title;
/** 展示图片模型对象 */
@property (nonatomic, strong) PDImageModel *image;
/** 小组信息描述 */
@property (nonatomic, copy) NSString *intro;
/** 小组动画数目 */
@property (nonatomic, strong) Itemcount *itemCount;
/**  动画信息模型 */
@property (nonatomic, strong) NSArray<Items *> *items;
@property (nonatomic, assign) NSInteger epPlayCount;

@end

#pragma mark 第二层

/**
 *  展示的动画总数目模型
 */
@interface Itemcount : XYSBaseModel

/** 总数目 */
@property (nonatomic, assign) NSInteger anime;

@property (nonatomic, assign) NSInteger ep;

@end

/** 单个动画信息模型 */
@interface Items : XYSBaseModel

@property (nonatomic, copy) NSString *itemId;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *albumId;

@property (nonatomic, assign) NSInteger type;
/** 单个剧集动画信息模型 */
@property (nonatomic, strong) PDAnimeModel *item;
/** 动画简介 */
@property (nonatomic, copy) NSString *intro;

@end





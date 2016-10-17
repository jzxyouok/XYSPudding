//
//  PDAnimeGroupListModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseViewModel.h"

@interface PDAnimeGroupListViewModel : XYSBaseViewModel

#pragma mark - 4个并排的

/** 分组数目 */
@property (nonatomic, assign) NSInteger groupNumber;

/** 分组组头标题 */
- (NSString *)titleWithIndex:(NSInteger)index;
/** 组动画种类数目 */
- (NSInteger)numberOfAnimesSpeciesWithIndex:(NSInteger)index;
/** 组展示的动画数目 */
- (NSInteger)numberOfDisplayWithIndex:(NSInteger)index;

/** 动画展示图片 */
- (NSURL *)displayImageURLWithIndex:(NSInteger)index
                         AnimeIndex:(NSInteger)aIndex;
/** 展示的动画的更新集数标签 */
- (NSInteger)numberOfDisplayAnimesWithIndex:(NSInteger)index
                                 AnimeIndex:(NSInteger)aIndex;
/** 展示的动画名称标签 */
- (NSString *)animeNameWithIndex:(NSInteger)index
                      AnimeIndex:(NSInteger)aIndex;
@end

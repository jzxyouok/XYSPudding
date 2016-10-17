//
//  PDAnimeGroupListModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDAnimeGroupListViewModel.h"
#import "PDHPNetwork.h"
#import "PDAnimeGroupListModel.h"

@interface PDAnimeGroupListViewModel ()
{
    NSInteger _offset;
}

@end

@implementation PDAnimeGroupListViewModel

- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    _offset = 0;
    [self.datas removeAllObjects];
    [self getDataWithloadType:XYSDataLoadTypeNew
            completionHandler:completionHandler];
}

- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    _offset += 20;
    [self getDataWithloadType:XYSDataLoadTypeMore
            completionHandler:completionHandler];
}

- (void)getDataWithloadType:(XYSDataLoadType)loadType
          completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    
    self.dataTask = [PDHPNetwork loadAnimGroupListDataWithOffset:_offset
                                               completionHandler:^(NSArray *model,
                                                                   NSError *error)
                     {
                         if (!error)
                         {
                             [self.datas addObjectsFromArray:model];
                         }
                         completionHandler(error);
                     }];
}

/** 分组数目 */
- (NSInteger)groupNumber
{
    return self.datas.count;
}


- (PDAnimeGroupListModel *)getModelDataWithIndex:(NSInteger)index
{
    return self.datas[index];
}

- (Items *)getItemsModelDataWithIndex:(NSInteger)index
                           animeIndex:(NSInteger)aIndex
{
    return [self getModelDataWithIndex:index].items[aIndex];
}


/** 分组组头标题 */
- (NSString *)titleWithIndex:(NSInteger)index
{
    return [self getModelDataWithIndex:index].title;
}
/** 组动画种类数目 */
- (NSInteger)numberOfAnimesSpeciesWithIndex:(NSInteger)index
{
    return [self getModelDataWithIndex:index].itemCount.anime;
}
/** 每组展示的动画数目(一般是4个) */
- (NSInteger)numberOfDisplayWithIndex:(NSInteger)index
{
    return [self getModelDataWithIndex:index].items.count;
}

/** 动画展示图片 */
- (NSURL *)displayImageURLWithIndex:(NSInteger)index
                         AnimeIndex:(NSInteger)aIndex
{
    return [NSURL URLWithString:[self getItemsModelDataWithIndex:index animeIndex:aIndex].item.image.url];
}
/** 展示的动画的更新集数标签 */
- (NSInteger)numberOfDisplayAnimesWithIndex:(NSInteger)index
                                 AnimeIndex:(NSInteger)aIndex
{
    return [self getItemsModelDataWithIndex:index animeIndex:aIndex].item.pushedEpNumber;
}
/** 展示的动画名称标签 */
- (NSString *)animeNameWithIndex:(NSInteger)index
                      AnimeIndex:(NSInteger)aIndex
{
    return [self getItemsModelDataWithIndex:index animeIndex:aIndex].item.name;
}

@end

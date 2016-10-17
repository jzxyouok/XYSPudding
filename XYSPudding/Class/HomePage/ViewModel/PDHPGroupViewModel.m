//
//  PDHPGroupViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHPGroupViewModel.h"
#import "PDHPGroupModel.h"
#import "PDHPLatestModel.h"

@interface PDHPGroupViewModel ()

@property (nonatomic, assign) NSInteger offset;

@end
@implementation PDHPGroupViewModel

/** 传入分组类型 */
- (instancetype)initWithGroupStyle:(PDHPGroupStyle)style
{
    if (self = [super init])
    {
        _style = style;
    }
    return self;
}
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    switch (_style)
    {
            /** 番组推荐 */
        case PDHPGroupStyleRecommend:
        {
            _offset = 4;
            break;
        }
            /** 最近更新 */
        case PDHPGroupStyleLatest:
        {
            _offset = 4;
            break;
        }
            /** 国产动画 */
        case PDHPGroupStyleDomesticAnimation:
        {
            _offset = 4;
            break;
        }
            /** 完结推荐 */
        case PDHPGroupStyleEndRecommend:
        {
            _offset = 4;
            break;
        }
    }
    
    [self getDataWithloadType:XYSDataLoadTypeNew
            completionHandler:completionHandler];
}

- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    
}

- (void)getDataWithloadType:(XYSDataLoadType)loadType
          completionHandler:(void (^)(NSError *))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    [PDHPNetwork loadAnimGroupDataWithOffset:0
                                 groupStryle:_style
                           completionHandler:^(id model, NSError *error)
    {
        if (!error)
        {
            /** 最近更新 */
            if (_style == PDHPGroupStyleLatest)
            {
                PDHPLatestModel *latestM = (PDHPLatestModel *)model;
                
                for (PDEpsModel *epsModel in latestM.result.epsList)
                {
                    [self.datas addObject:epsModel];
                }
            }
            /** 完结推荐 */
            else if (_style == PDHPGroupStyleEndRecommend)
            {
                [self.datas addObjectsFromArray:(NSArray *)model];
            }
            /** 国产动漫、番组推荐 */
            else
            {
                PDHPGroupModel *groupM = (PDHPGroupModel *)model;
                [self.datas addObjectsFromArray:groupM.result.animeList];
            }
        }
        completionHandler(error);
    }];
}

/** 动画数目 */
- (NSInteger)animeNumber
{
    if (self.datas.count>0)
    {
        return 4;
    }
    return 0;
}

/** 获取数据 */
- (PDAnimeModel *)getModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 图片url */
- (NSURL *)imageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].image.url];
}
/** 动漫名称 */
- (NSString *)animeNameWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].name;
}
/** 播放数目 */
- (NSInteger)playCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].displayPlayCount;
}
/** 更新到的集数 */
- (NSInteger)latestCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].pushedEpNumber;
}

@end

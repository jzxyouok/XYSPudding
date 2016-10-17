//
//  PDPropGoodsListViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPropGoodsListViewModel.h"
#import "PDPropNetwork.h"
#import "PDPropGroodsListModel.h"

@interface PDPropGoodsListViewModel ()

/** 传入请求参数 */
@property (nonatomic, strong) NSDictionary *parameters;
/** 偏移量 */
@property (nonatomic, assign) NSInteger offset;
/** 储存分类商品数据 */
@property (nonatomic, strong) NSArray *catogryGoods;

@end

@implementation PDPropGoodsListViewModel

/** 修改获取更多数据的请求参数 */
- (NSMutableDictionary *)parametersWithOffset
{
        NSMutableArray *allkeys = [NSMutableArray arrayWithArray:_parameters.allKeys];
        NSMutableArray *allValues = [NSMutableArray arrayWithArray:_parameters.allValues];
        NSInteger index = [allkeys indexOfObject:@"model"];
        [allkeys insertObject:@(_offset) atIndex:index+1];
        [allValues insertObject:@"offset" atIndex:index+1];
        
     return [NSMutableDictionary dictionaryWithObjects:allValues
                                                           forKeys:allkeys];
}
/** 刷新数据 */
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    /** 首先获取请求参数 */
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDPropNetwork loadParametersDataWithCompletionHandler:^(PDPropGroodsListModel *model, NSError *error)
                     {
                         if (!error)
                         {
                             _goodsNumber = 0;
                             _offset = 0;
                             _parameters = [model.parameters copy];
                             [self.datas removeAllObjects];
                             
                             /** 获取分类商品数据 */
                             if (self.dataTask)
                             {
                                 [self.dataTask cancel];
                             }
                             self.dataTask = [PDPropNetwork loadCatogryGoodsDataWithParameters:_parameters
                                                                             CompletionHandler:^(PDPropGroodsListModel *model,
                                                                                                 NSError *error)
                                              {
                                                  if (!error)
                                                  {
                                                      _catogryGoods = [model.result.goodsList copy];
                                                  }
                                                  
                                                  /** 获取商品列表数据 */
                                                  [self getDataWithloadType:XYSDataLoadTypeNew
                                                          completionHandler:completionHandler];
                                              }];
                         }
                         else
                         {
                             completionHandler(error);
                         }
                     }];
}

/** 获取更多数据 */
- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    _offset += 20;
    _parameters = [[self parametersWithOffset] copy];
    [self getDataWithloadType:XYSDataLoadTypeMore
            completionHandler:completionHandler];
}

/** 获取数据 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType
          completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDPropNetwork loadListGoodsDataWithParameters:_parameters
                                                 CompletionHandler:^(PDPropGroodsListModel *model,
                                                                     NSError *error)
    {
        if (!error)
        {
            [self.datas addObjectsFromArray:model.result.goodsList];
            _goodsNumber += model.result.total;
        }
        completionHandler(error);
    }];
}


#pragma mark - 获取商品列表数据

/** 获取商品数据模型对象 */
- (PDGoodsModel *)getModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 图片 */
- (NSURL *)imageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].square.url];
}
/** 标签（new\hot\无） */
- (NSString *)labelWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].label;
}
/** 标题信息 */
- (NSString *)titleWithIndex:(NSInteger)index
{
    if ([self labelWithIndex:index] && ![[self labelWithIndex:index] isEqualToString:@""])
    {
        return [@"         " stringByAppendingString:[self getModelWithIndex:index].title];
    }
    return [self getModelWithIndex:index].title;
}
/** 价格 */
- (CGFloat)priceWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].price /100.0;
}
/** 浏览人数 */
- (NSInteger)numberOfVisitorsWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].viewCount;
}

#pragma mark - 分类商品列表数据

/** 获取商品数据模型对象 */
- (PDGoodsModel *)getCModelWithIndex:(NSInteger)index
{
    return _catogryGoods[index];
}

/** 分类商品数目 */
- (NSInteger)catogryGoodsNumber
{
    return _catogryGoods.count;
}
/** 分类商品图标 */
- (NSURL *)catogryIconURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getCModelWithIndex:index].iosImage.url];
}

@end

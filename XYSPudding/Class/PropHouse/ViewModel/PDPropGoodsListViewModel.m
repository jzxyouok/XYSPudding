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
@end

@implementation PDPropGoodsListViewModel

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
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    /** 首先获取请求参数 */
    [PDPropNetwork loadParametersDataWithCompletionHandler:^(PDPropGroodsListModel *model, NSError *error)
    {
        if (!error)
        {
            _goodsNumber = 0;
            _offset = 0;
            _parameters = [model.parameters copy];
            [self.datas removeAllObjects];
            [self getDataWithloadType:XYSDataLoadTypeNew
                    completionHandler:completionHandler];
        }
        else
        {
            completionHandler(error);
        }
    }];
}

- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    _offset += 20;
    _parameters = [[self parametersWithOffset] copy];
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
    self.dataTask = [PDPropNetwork loadListGoodsDataWithParameters:_parameters
                                                 CompletionHandler:^(PDPropGroodsListModel *model,
                                                                     NSError *error)
    {
        if (!error)
        {
            [self.datas addObjectsFromArray:model.result.list];
            _goodsNumber += model.result.total;
        }
        completionHandler(error);
    }];
}


#pragma mark - 获取数据


- (PDPropGroodsListResultListModel *)getModelWithIndex:(NSInteger)index
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

@end

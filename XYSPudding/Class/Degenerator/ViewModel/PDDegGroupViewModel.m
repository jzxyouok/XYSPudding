//
//  PDDegGroupViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupViewModel.h"
#import "PDDegNetwork.h"
#import "PDDegGroupModel.h"


@interface PDDegGroupViewModel ()

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;

@end

@implementation PDDegGroupViewModel

/** 单例 */
+ (id)defaultGroupViewModel
{
    static PDDegGroupViewModel *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        obj = [PDDegGroupViewModel new];
    });
    return obj;
}

/** 刷新数据 */
- (void)refreshDataWithGrupStyle:(NSInteger)style
               CompletionHandler:(void (^)(NSError *error))completionHandler
{
    if (style == 0)
    {
        _limit = 8;
    }
    else if (style == 1)
    {
        _limit = 12;
    }
    else
    {
        _limit = 20;
        _offset = 20;
    }
    [self.datas removeAllObjects];
    [self getDataWithloadType:XYSDataLoadTypeNew
            completionHandler:completionHandler];
}

/** 获取更多数据 */
- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    _offset += 20;
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
    self.dataTask = [PDDegNetwork loadGroupListDataWithLimit:_limit
                                                  offset:_offset
                                       CompletionHandler:^(NSArray *model, NSError *error)
                     {
                         if (!error)
                         {
                             [self.datas addObjectsFromArray:model];
                         }
                         completionHandler(error);
                     }];
}

/** 获取model数据 */
- (PDDegGroupModel *)getGroupModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 分组数目 */
- (NSInteger)groupNumber
{
    return self.datas.count;
}
/** 分组展示图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getGroupModelWithIndex:index].icon.url];
}
/** 分组名称 */
- (NSString *)nameWithIndex:(NSInteger)index
{
    return [self getGroupModelWithIndex:index].name;
}

/** 分组详情展示背景图URL */
- (NSURL *)backgroundImageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getGroupModelWithIndex:index].background.url];
}
/** 分组详情页的小组id */
- (NSString *)groupIDWithIndex:(NSInteger)index
{
    return [self getGroupModelWithIndex:index]._id;
}

/** 小组成员数目 */
- (NSString *)memberCountWithIndex:(NSInteger)index
{
    NSInteger count = [self getGroupModelWithIndex:index].memberCount;
    
    if (count <= 9999)
    {
        return [NSString stringWithFormat:@"成员:%@", @(count)];
    }
    return [NSString stringWithFormat:@"成员:%@万", @(count/10000)];
}
/** 今日主题数目 */
- (NSString *)todayTopicCountWithIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"今日主题:%@", @([self getGroupModelWithIndex:index].todayTopicCount)];
}

@end

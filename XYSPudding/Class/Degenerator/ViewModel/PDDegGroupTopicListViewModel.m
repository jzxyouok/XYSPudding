//
//  PDDegGroupTopicListViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupTopicListViewModel.h"
#import "PDDegNetwork.h"
#import "PDDegGroupTopicListModel.h"

@implementation PDDegGroupTopicListViewModel

/** 通过传入的id获取请求数据 */
- (instancetype)initWithID:(NSString *)id_
{
    if (self = [super init])
    {
        _id_ = id_;
    }
    return self;
}

/** 刷新数据 */
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [self.datas removeAllObjects];
    [self getDataWithloadType:XYSDataLoadTypeNew
            completionHandler:completionHandler];
}
/** 获取更多数据 */
- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [self getDataWithloadType:XYSDataLoadTypeNew
            completionHandler:completionHandler];
}
/** 加载数据 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDDegNetwork loadGroupTopicListDataWithID:_id_
                                             completionHandler:^(NSArray *model, NSError *error)
                     {
                         if (!error)
                         {
                             [self.datas addObjectsFromArray:model];
                             if (loadType == XYSDataLoadTypeNew)
                             {
                                 [self.datas removeObjectAtIndex:2];
                                 [self.datas removeObjectAtIndex:1];
                                 [self.datas removeObjectAtIndex:0];
                             }
                         }
                         completionHandler(error);
                     }];
}

#pragma mark - 视图数据获取

/** 获取指定的模型 */
- (PDDegGroupTopicListModel *)getModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 主题数目 */
- (NSInteger)listNumber
{
    return self.datas.count;
}
/** 头像url */
- (NSURL *)avatarURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].user.avatar.url];
}
/** 昵称 */
- (NSString *)nickNameWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].user.nickname;
}
/** 发布时间 */
- (NSString *)presentTimeWithIndex:(NSInteger)index
{
    NSInteger seconds = [self getModelWithIndex:index].replyTime - [self getModelWithIndex:index].replyTime;
    
    if (seconds < 60)
    {
        return [NSString stringWithFormat:@"%@秒前", @(seconds)];
    }
    else if (seconds/60 < 60)
    {
        return [NSString stringWithFormat:@"%@分钟前", @(seconds/60)];
    }
    else if (seconds/3600 < 24)
    {
        return [NSString stringWithFormat:@"%@小时前", @(seconds/3600)];
    }
    return [NSString stringWithFormat:@"%@天前", @(seconds/3600/24)];
}
/** 文本内容 */
- (NSString *)contentWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].content;
}
/** 是否被关注 */
- (BOOL)isConcernedWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].selected;
}

/** 是否包含图片 */
- (BOOL)isContainImageWithIndex:(NSInteger)index
{
    if ([self getModelWithIndex:index].images && [self getModelWithIndex:index].images.count>0)
    {
        return YES;
    }
    return NO;
}
/** 图片数目 */
- (NSInteger)imageNumberWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].images.count;
}
/** 图片url地址 */
- (NSURL *)imageURLWithRowIndex:(NSInteger)rIndex imageIndex:(NSInteger)iIndex
{
    return [NSURL URLWithString:[self getModelWithIndex:rIndex].images[iIndex].url];
}

/** 转发数目 */
- (NSInteger)repostCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].activity.repostCount;
}
/** 点赞数目 */
- (NSInteger)praiseCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].voteCount;
}
/** 回复数目 */
- (NSInteger)replyCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].replyCount;
}

@end

//
//  PDDegImageViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegImageViewModel.h"
#import "PDDegImageModel.h"
#import "PDDegNetwork.h"

@implementation PDDegImageViewModel

/** 刷新数据 */
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [self.datas removeAllObjects];
    [self getDataWithloadType:XYSDataLoadTypeNew completionHandler:completionHandler];
}

/** 获取更多数据 */
- (void)getMoreDataWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [self getDataWithloadType:XYSDataLoadTypeMore completionHandler:completionHandler];
}

/** 获取数据 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDDegNetwork loadImageListDataWithloadType:loadType
                                                       userInfo:nil
                                              completionHandler:^(id model, NSDictionary *userInfo, NSError *error)
                     {
                         [self.datas addObjectsFromArray:(NSArray *)model];
                         completionHandler(error);
                     }];
}

/** 获取模型对象 */
- (PDDegImageModel *)getModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 图片主题列表数目 */
- (NSInteger)listNumber
{
    return self.datas.count;
}
/** cell大小 */
- (CGSize)cellSizeWithIndex:(NSInteger)index
{
   
    CGFloat height = 45*kScreenWidth/1024 + 1 + 10 + 40*kScreenWidth/1024 + [self imageSizeWithIndex:index].height;
    
    CGFloat contentH =[[self contentWithIndex:index]
                       boundingRectWithSize:CGSizeMake(160*kScreenWidth/1024 - 20 , MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                       context:nil].size.height; //文本内容高度
    if (contentH>0)
    {
        height += contentH*kScreenWidth/1024 + 10;
    }
    return CGSizeMake(160*kScreenWidth/1024, height);
}


/** 展示的图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].image.url];
}
/** 用户头像 */
- (NSURL *)avatarURLWithImdex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].user.avatar.url];
}
/** 用户昵称 */
- (NSString *)userNameWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].user.nickname;
}
/** 图片主题发布的大概时间 */
- (NSString *)presentTimeWithIndex:(NSInteger)index
{
    
    NSInteger seconds = [self getModelWithIndex:index].lastCommentedTime - [self getModelWithIndex:index].insertedTime;
    
    
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
/** 文字内容 */
- (NSString *)contentWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].content;
}
/** 图片大小 */
- (CGSize)imageSizeWithIndex:(NSInteger)index
{
    CGFloat width = [self getModelWithIndex:index].image.width;
    CGFloat height = [self getModelWithIndex:index].image.height;
    CGFloat scale = width / 160.0;
    return CGSizeMake(160*kScreenWidth/1024, height/scale*kScreenWidth/1024);
}
/** 收藏数目 */
- (NSInteger)numberOfVoteWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].voteCount;
}
/** 评论数目 */
- (NSInteger)numberOfReplyWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].replyCount;
}

/** 详情页面背景图 */
- (NSURL *)backgroundImageWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].user.background.url];
}


@end

//
//  PDTLTopicViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTLTopicViewModel.h"
#import "PDTLNetwork.h"
#import "PDTLTopicModel.h"

@interface PDTLTopicViewModel ()
{
    NSInteger _offset;
}
@end

@implementation PDTLTopicViewModel

/** 获取数据 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType
          completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    
    if (loadType == XYSDataLoadTypeNew)
    {
        _offset = 0;
    }
    else
    {
        _offset += 20;
    }
    self.dataTask = [PDTLNetwork loadDataWithloadType:loadType
                                             userInfo:@{@"offset" : @(_offset)}
                                    completionHandler:^(NSArray *model,
                                                        NSDictionary *userInfo,
                                                        NSError *error)
                     {
                         if (!error)
                         {
                             [self.datas addObjectsFromArray:model];
                         }
                         completionHandler(error);
                     }];
}

/** 获取模型对象 */
- (PDTLTopicModel *)getModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}

/** 图片主题列表数目 */
- (NSInteger)listNumber
{
    return self.datas.count;
}
/** cell大小 */
- (CGFloat)heightOfCellWithIndex:(NSInteger)index
{
    CGFloat height = (15 + 13 + 40 + 13 + 44)*kScale + 1;
    
    
    CGFloat contentH = [[self contentWithIndex:index]
                        boundingRectWithSize:CGSizeMake((540 - 26)*kScale, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15*kScale]}
                        context:nil].size.height; //文本内容高度
    if (contentH>0)
    {
        height += contentH + 13*kScale;
    }
    
    if ([self isContainImageWithIndex:index])
    {
        NSInteger row = ([self imageNumberWithIndex:index]+2)/3;
        
        height += (164 + 13)*row*kScale;
    }
    return height;
}
/** 头像url */
- (NSURL *)avatarURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getModelWithIndex:index].ownerObject.avatar.url];
}
/** 昵称 */
- (NSString *)nickNameWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].ownerObject.nickname;
}
/** 发布时间 */
- (NSString *)presentTimeWithIndex:(NSInteger)index
{
    NSInteger seconds = [self getModelWithIndex:index].relatedObject.replyTime - [self getModelWithIndex:index].postedTime;
    
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
    return [self getModelWithIndex:index].relatedObject.content;
}
/** 是否被关注 */
- (BOOL)isConcernedWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].ownerObject.blocked;
}

/** 是否包含图片 */
- (BOOL)isContainImageWithIndex:(NSInteger)index
{
    if ([self getModelWithIndex:index].relatedObject.images && [self getModelWithIndex:index].relatedObject.images.count>0)
    {
        NSLog(@"...");
        return YES;
    }
    return NO;
}
/** 图片数目 */
- (NSInteger)imageNumberWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].relatedObject.images.count;
}
/** 图片url地址 */
- (NSURL *)imageURLWithRowIndex:(NSInteger)rIndex imageIndex:(NSInteger)iIndex
{
    return [NSURL URLWithString:[self getModelWithIndex:rIndex].relatedObject.images[iIndex].url];
}

/** 转发数目 */
- (NSInteger)repostCountWithIndex:(NSInteger)index
{
    return [self getModelWithIndex:index].subject.postCount;
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

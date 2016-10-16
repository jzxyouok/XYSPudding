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

@implementation PDTLTopicViewModel

/** 获取数据 */
- (void)getDataWithloadType:(XYSDataLoadType)loadType completionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDTLNetwork loadDataWithloadType:loadType
                                             userInfo:nil
                                    completionHandler:^(id model, NSDictionary *userInfo, NSError *error)
                     {
                         [self.datas addObjectsFromArray:(NSArray *)model];
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
///** cell大小 */
//- (CGSize)cellSizeWithIndex:(NSInteger)index
//{
//    CGFloat height = [self imageSizeWithIndex:index].height + 50*kScale - 10*kScale + 13*kScale + 45*kScale + 1;
//    
//    CGFloat contentH = [[self contentWithIndex:index]
//                        boundingRectWithSize:CGSizeMake((160 - 25)*kScale, MAXFLOAT)
//                        options:NSStringDrawingUsesLineFragmentOrigin
//                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15*kScale]}
//                        context:nil].size.height; //文本内容高度
//    if (contentH>0)
//    {
//        if (contentH >45)
//        {
//            height += 45*kScale + 45*kScale;
//        }
//        else
//        {
//            height += contentH*kScale + 25*kScale;
//        }
//    }
//    return CGSizeMake(160*kScale, height);
//}
//
///** 展示的图片URL */
//- (NSURL *)imageURLWithIndex:(NSInteger)index
//{
//    return [NSURL URLWithString:[self getModelWithIndex:index].ownerObject.avatar.url];
//}
///** 用户头像 */
//- (NSURL *)avatarURLWithImdex:(NSInteger)index
//{
//    return [NSURL URLWithString:[self getModelWithIndex:index].ownerObject.avatar.url];
//}
///** 用户昵称 */
//- (NSString *)userNameWithIndex:(NSInteger)index
//{
//    return [self getModelWithIndex:index].ownerObject.nickname;
//}
///** 图片主题发布的大概时间 */
//- (NSString *)presentTimeWithIndex:(NSInteger)index
//{
//    NSInteger seconds = [self getModelWithIndex:index].lastCommentedTime - [self getModelWithIndex:index].insertedTime;
//    
//    if (seconds < 60)
//    {
//        return [NSString stringWithFormat:@"%@秒前", @(seconds)];
//    }
//    else if (seconds/60 < 60)
//    {
//        return [NSString stringWithFormat:@"%@分钟前", @(seconds/60)];
//    }
//    else if (seconds/3600 < 24)
//    {
//        return [NSString stringWithFormat:@"%@小时前", @(seconds/3600)];
//    }
//    return [NSString stringWithFormat:@"%@天前", @(seconds/3600/24)];
//}
///** 文字内容 */
//- (NSString *)contentWithIndex:(NSInteger)index
//{
//    return [self getModelWithIndex:index].relatedObject.content;
//}
///** 图片大小 */
//- (CGSize)imageSizeWithIndex:(NSInteger)index
//{
//    CGFloat width = [self getModelWithIndex:index].image.width;
//    CGFloat height = [self getModelWithIndex:index].image.height * 160.0 / width;
//    
//    if (height > 320) //图片高度限制在320
//    {
//        height = 320;
//    }
//    return CGSizeMake(160*kScale, height*kScale);
//}
///** 收藏数目 */
//- (NSInteger)numberOfVoteWithIndex:(NSInteger)index
//{
//    return [self getModelWithIndex:index].voteCount;
//}
///** 评论数目 */
//- (NSInteger)numberOfReplyWithIndex:(NSInteger)index
//{
//    return [self getModelWithIndex:index].replyCount;
//}
//
///** 详情页面背景图 */
//- (NSURL *)backgroundImageWithIndex:(NSInteger)index
//{
//    return [NSURL URLWithString:[self getModelWithIndex:index].user.background.url];
//}

@end

//
//  PDDegImageViewModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseViewModel.h"

@interface PDDegImageListViewModel : XYSBaseViewModel

/** 图片主题列表数目 */
@property (nonatomic, assign) NSInteger listNumber;
/** cell大小 */
- (CGSize)cellSizeWithIndex:(NSInteger)index;

/** 展示的图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index;
/** 用户头像 */
- (NSURL *)avatarURLWithImdex:(NSInteger)index;
/** 用户昵称 */
- (NSString *)userNameWithIndex:(NSInteger)index;
/** 图片主题发布的大概时间 */
- (NSString *)presentTimeWithIndex:(NSInteger)index;
/** 文字内容 */
- (NSString *)contentWithIndex:(NSInteger)index;
/** 图片大小 */
- (CGSize)imageSizeWithIndex:(NSInteger)index;
/** 收藏数目 */
- (NSInteger)numberOfVoteWithIndex:(NSInteger)index;
/** 评论数目 */
- (NSInteger)numberOfReplyWithIndex:(NSInteger)index;

/** 详情页面背景图 */
- (NSURL *)backgroundImageWithIndex:(NSInteger)index;

@end

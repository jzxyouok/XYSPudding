//
//  PDHPGroupViewModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseViewModel.h"
#import "PDHPNetwork.h"

@class PDHPGroupModel;

@interface PDHPGroupViewModel : XYSBaseViewModel

/** 传入分组类型 */
- (instancetype)initWithGroupStyle:(PDHPGroupStyle)style;
@property (nonatomic, assign, readonly) PDHPGroupStyle style;


/** 动画数目 */
@property (nonatomic, assign) NSInteger animeNumber;

/** 图片url */
- (NSURL *)imageURLWithIndex:(NSInteger)index;
/** 动漫名称 */
- (NSString *)animeNameWithIndex:(NSInteger)index;
/** 播放数目 */
- (NSInteger)playCountWithIndex:(NSInteger)index;
/** 更新到的集数 */
- (NSInteger)latestCountWithIndex:(NSInteger)index;

@end

//
//  PDDegGroupViewModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseViewModel.h"

@interface PDDegGroupViewModel : XYSBaseViewModel

/** 分组数目 */
@property (nonatomic, assign) NSInteger groupNumber;
/** 分组展示图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index;
/** 分组名称 */
- (NSString *)nameWithIndex:(NSInteger)index;

/** 分组详情展示背景图URL */
- (NSURL *)backgroundImageURLWithIndex:(NSInteger)index;
@end

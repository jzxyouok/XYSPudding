//
//  PDPropGoodsListViewModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseViewModel.h"

@interface PDPropGoodsListViewModel : XYSBaseViewModel

/** 商品数目 */
@property (nonatomic, assign) NSInteger goodsNumber;
/** 图片 */
- (NSURL *)imageURLWithIndex:(NSInteger)index;
/** 标签（new\hot\无） */
- (NSString *)labelWithIndex:(NSInteger)index;
/** 标题信息 */
- (NSString *)titleWithIndex:(NSInteger)index;
/** 价格 */
- (CGFloat)priceWithIndex:(NSInteger)index;
/** 浏览人数 */
- (NSInteger)numberOfVisitorsWithIndex:(NSInteger)index;

/** 分类商品数目 */
@property (nonatomic, assign) NSInteger catogryGoodsNumber;
/** 分类商品图标 */
- (NSURL *)catogryIconURLWithIndex:(NSInteger)index;

@end

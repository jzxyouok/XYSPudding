//
//  PDProCatogryDoodsCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDPropGoodsListViewModel.h"

@interface PDProCatogryGoodsCell : UICollectionViewCell

/** 传入分类商品列表数据模型对象 */
@property (nonatomic, strong) PDPropGoodsListViewModel *goodsListVM;

@end

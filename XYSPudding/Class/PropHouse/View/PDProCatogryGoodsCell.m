//
//  PDProCatogryDoodsCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDProCatogryGoodsCell.h"

/** 分类数目 */
#define kCatogryGoodsCount 4

@implementation PDProCatogryGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelected:NO];
        [self addImageViewList];
    }
    return self;
}

/** 添加商品展示视图列表 */
- (void)addImageViewList
{
    UIButton *lastView = nil;
    for (NSInteger i = 0; i < kCatogryGoodsCount; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i+100];
        [button setContentMode:UIViewContentModeScaleAspectFill];
        [button setClipsToBounds:YES];
        [button.layer setCornerRadius:7*kScaleW];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(10*kScaleW);
            make.bottom.mas_equalTo(-10*kScaleW);
            if (lastView)
            {
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10*kScaleW);
                make.width.mas_equalTo(lastView);
            }
            else
            {
                make.left.mas_equalTo(10*kScaleW);
            }
            
            if (i == kCatogryGoodsCount-1)
            {
                make.right.mas_equalTo(-10*kScaleW);
            }
        }];
        
        lastView = button;
    }
}

/** 传入分类商品列表数据模型对象 */
- (void)setGoodsListVM:(PDPropGoodsListViewModel *)goodsListVM
{
    _goodsListVM = goodsListVM;
    
    for (NSInteger i = 0; i < _goodsListVM.catogryGoodsNumber; i++)
    {
        UIButton *button = (UIButton *)[self viewWithTag:100+i];
        [button setBackgroundImageForState:UIControlStateNormal
                              withURL:[_goodsListVM catogryIconURLWithIndex:i]
                     placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
    }
}

@end

//
//  PDAnimeGroupHeadView.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDAnimeGroupHeadView.h"

@implementation PDAnimeGroupHeadView

/** 分组标题 */
- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [_titleLabel setTextColor:kTextColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:14*kScaleW]];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(20*kScaleW);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}
/** 小组动画种类数目 */
- (UILabel *)countOfSpeciesLabel
{
    if(!_countOfSpeciesLabel)
    {
        _countOfSpeciesLabel = [UILabel new];
        [_countOfSpeciesLabel setTextColor:[UIColor lightGrayColor]];
        [_countOfSpeciesLabel setFont:[UIFont systemFontOfSize:12*kScaleW]];
        [self addSubview:_countOfSpeciesLabel];
        [_countOfSpeciesLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.mas_equalTo(-20*kScaleW);
             make.centerY.mas_equalTo(0);
         }];
    }
    return _countOfSpeciesLabel;
}

@end

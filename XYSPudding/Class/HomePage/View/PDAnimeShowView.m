//
//  PDAnimeShowView.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDAnimeShowView.h"

@implementation PDAnimeShowView

/** 动画展示图片 */
- (UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [_imageView.layer setCornerRadius:3*kScaleW];
        [_imageView setClipsToBounds:YES];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-35*kScaleW);
        }];
    }
    return _imageView;
}

/** 总集数标签 */
- (UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [UILabel new];
        [_numberLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
        [_numberLabel setFont:[UIFont systemFontOfSize:12*kScaleW]];
        [_numberLabel setTextColor:[UIColor whiteColor]];
        [self.imageView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.bottom.right.mas_equalTo(0);
             make.height.mas_equalTo(18*kScaleW);
         }];
    }
    return _numberLabel;
}
/** 动画名称标签 */
- (UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [UILabel new];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setFont:[UIFont systemFontOfSize:12*kScaleW]];
        [_nameLabel setTextColor:kTextColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.bottom.right.mas_equalTo(0);
             make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(0);
         }];
    }
    return _nameLabel;
}


@end

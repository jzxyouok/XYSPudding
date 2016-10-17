//
//  PDHPGroupView.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHPGroupView.h"

@implementation PDHPGroupView

/** 动画展示图片 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(160*kScaleW);
        }];
    }
    return _imageView;
}
/** 播放数目标签 */
- (UILabel *)playCountLabel
{
    if (!_playCountLabel)
    {
        _playCountLabel = [UILabel new];
        [self.imageView addSubview:_playCountLabel];
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.mas_equalTo(-10*kScaleW);
            make.bottom.mas_equalTo(-10*kScaleW);
        }];
    }
    return _playCountLabel;
}
/** 动画名称标签 */
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel new];
        [_nameLabel setFont:[UIFont systemFontOfSize:13*kScaleW]];
        [_nameLabel setTextColor:kTextColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(20*kScaleW);
             make.left.mas_equalTo(20*kScaleW);
             make.right.mas_equalTo(-20*kScaleW);
         }];
    }
    return _nameLabel;
}
/** 更新的总集数标签 */
- (UILabel *)numberLabel
{
    if (!_numberLabel)
    {
        _numberLabel = [UILabel new];
        [_numberLabel setFont:[UIFont systemFontOfSize:11*kScaleW]];
        [_numberLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(10*kScaleW);
             make.left.mas_equalTo(20*kScaleW);
             make.right.mas_equalTo(-20*kScaleW);
         }];
    }
    return _numberLabel;
}
@end

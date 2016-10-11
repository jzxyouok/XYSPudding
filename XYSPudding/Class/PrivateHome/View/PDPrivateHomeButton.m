//
//  PDPrivateHomeButton.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPrivateHomeButton.h"

@interface PDPrivateHomeButton ()
{
    /** 底层视图 */
    UIView *_bottomView;
    /** 图片视图 */
    UIImageView *_imageView;
    /** 标题标签 */
    UILabel *_titleLabel;
    /** 图片标签 */
    UIImageView *_imageLabel;
}
@end

@implementation PDPrivateHomeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addBottomView];
        [self addImageView];
        [self addTitleLabel];
        [self addImageTag];
    }
    return self;
}

#pragma Mark - 视图配置

/** 添加配置好的底层视图 */
- (void)addBottomView
{
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-35);
        make.bottom.mas_equalTo(-40);
        
    }];
    [bottomView.layer setBorderWidth:1];
    [bottomView.layer setBorderColor:[[UIColor lightGrayColor ]colorWithAlphaComponent:0.5].CGColor];
    [bottomView.layer setCornerRadius:35];
    _bottomView = bottomView;
}
/** 添加配置好的图片的视图 */
- (void)addImageView
{
    UIImageView *imageView = [UIImageView new];
    [_bottomView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
    }];
    _imageView = imageView;
}

/** 添加配置好的标题标签 */
- (void)addTitleLabel
{
    UILabel *titleLabel = [UILabel new];
    [_bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_imageView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    _titleLabel = titleLabel;
}

/** 添加配置好的图片标签 */
- (void)addImageTag
{
    UIImageView *imageLabel = [UIImageView new];
    [_bottomView addSubview:imageLabel];
    [imageLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    [imageLabel setImage:[UIImage imageNamed:@"home_anime_indicator_28x28_"]];
    _imageLabel = imageLabel;
}

#pragma mark - setter

/** 设置图片 */
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [_imageView setImage:[UIImage imageNamed:_imageName]];
}

/** 设置标题 */
- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

@end

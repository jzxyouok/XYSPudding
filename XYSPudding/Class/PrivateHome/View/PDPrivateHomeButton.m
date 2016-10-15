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
    /** 按钮视图 */
    UIButton *_button;
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
        [self addButton];
    }
    return self;
}

#pragma Mark - 视图配置

/** 添加配置好的底层视图 */
- (void)addBottomView
{
    UIView *bottomView = [UIView new];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [bottomView.layer setBorderWidth:1];
    [bottomView.layer setBorderColor:[[UIColor lightGrayColor ] colorWithAlphaComponent:0.5].CGColor];
    [bottomView.layer setCornerRadius:35*kScale];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(265*kScale);
        make.height.mas_equalTo(75*kScale);
        
    }];
    _bottomView = bottomView;
}
/** 添加配置好的图片的视图 */
- (void)addImageView
{
    UIImageView *imageView = [UIImageView new];
    [_bottomView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(5*kScale);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(60*kScale);
        make.height.mas_equalTo(60*kScale);
    }];
    _imageView = imageView;
}

/** 添加配置好的标题标签 */
- (void)addTitleLabel
{
    UILabel *titleLabel = [UILabel new];
    [titleLabel setFont:[UIFont systemFontOfSize:17*kScale]];
    [titleLabel setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
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
    [imageLabel setContentMode:UIViewContentModeScaleAspectFill];
    [_bottomView addSubview:imageLabel];
    [imageLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(-20*kScale);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(28*kScale);
        make.height.mas_equalTo(28*kScale);
    }];
    [imageLabel setImage:[UIImage imageNamed:@"home_anime_indicator_28x28_"]];
    _imageLabel = imageLabel;
}

/** 添加按钮 */
- (void)addButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button highlightBGDImage:[UIImage imageNamed:@"hilight"]];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.mas_equalTo(0);
    }];
    [button bk_addEventHandler:^(id sender)
    {
        if (_clickHandler)
        {
            _clickHandler(self.tag);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    _button = button;
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

- (void)clickHandler:(ClickHandler)clickHandler
{
    _clickHandler = clickHandler;
}


@end

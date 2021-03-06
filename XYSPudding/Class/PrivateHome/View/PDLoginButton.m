//
//  PDLoginButton.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDLoginButton.h"

@interface PDLoginButton ()
{
    UIImageView *_avatarView;
    UILabel *_label;
    UIImageView *_imageLabel;
}
@end

static NSString *const text = @"登录同步追番记录";

@implementation PDLoginButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addAvatarView];
        [self addLabel];
        [self addImageTag];
        [self highlightBGDImage:[UIImage imageNamed:@"hilight"]];
    }
    return self;
}

/** 添加配置好的头像视图 */
- (void)addAvatarView
{
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImage:[[UIImage imageNamed:@"default_avatar_64x64_"] circleImage]];
    [self addSubview:avatarView];
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(30*kScale);
        make.width.mas_equalTo(64*kScale);
        make.height.mas_equalTo(64*kScale);
    }];
    _avatarView = avatarView;
}

/** 添加配置好的文字标签 */
- (void)addLabel
{
    UILabel *label = [UILabel new];
    [label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:16*kScale]];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_avatarView.mas_right).mas_equalTo(10*kScale);
        make.topMargin.mas_equalTo(_avatarView);
    }];
    _label = label;
}

/** 添加配置好的图片标签 */
- (void)addImageTag
{
    UIImageView *imageLabel = [UIImageView new];
    [imageLabel setImage:[UIImage imageNamed:@"home_album_indicator_20x20_"]];
    [self addSubview:imageLabel];
    [imageLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.mas_equalTo(_label.mas_right).mas_equalTo(20*kScale);
        make.centerY.mas_equalTo(0);
         make.width.mas_equalTo(20*kScale);
         make.height.mas_equalTo(20*kScale);
    }];
    _imageLabel = imageLabel;
}

@end

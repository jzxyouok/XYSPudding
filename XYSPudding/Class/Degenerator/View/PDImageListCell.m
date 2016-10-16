//
//  PDImgaeListCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDImageListCell.h"
#import "UIImageView+WebCache.h"
#import "PDTopicButton.h"

@interface PDImageListCell ()

/** 展示的主题图片视图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 用户头像视图 */
@property (nonatomic, strong) UIImageView *avatar;
/** 用户昵称标签 */
@property (nonatomic, strong) UILabel *userNameLabel;
/** 文字内容标签 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 发布时间标签 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 交互按钮底层视图 */
@property (nonatomic, strong) UIView *buttonBgdView;
/** 线条 */
@property (nonatomic, strong) UIView *lineView;
/** 收藏按钮 */
@property (nonatomic, strong) PDTopicButton *voteButton;
/** 按钮中线 */
@property (nonatomic, strong) UIView *centerLineView;
/** 回复按钮 */
@property (nonatomic, strong) PDTopicButton *replyButton;

@end

@implementation PDImageListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:5];
        [self setClipsToBounds:YES];
    }
    return self;
}

#pragma mark - getter

/** 展示的主题图片视图 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make)
         {
             make.top.left.right.mas_equalTo(0);
         }];
    }
    return _imageView;
}
/** 用户头像视图 */
- (UIImageView *)avatar
{
    if (!_avatar)
    {
        _avatar = [UIImageView new];
        [self addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(15*kScale);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(-10*kScale);
            make.size.mas_equalTo(CGSizeMake(50*kScale, 50*kScale));
        }];
    }
    return _avatar;
}
/** 用户昵称标签 */
- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        _userNameLabel = [UILabel new];
        [self addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(self.avatar.mas_right).mas_equalTo(10*kScale);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(10*kScale);
            make.width.mas_equalTo(80*kScale);
        }];
        [_userNameLabel setFont:[UIFont systemFontOfSize:12*kScale]];
        [_userNameLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _userNameLabel;
}
/** 发布时间标签 */
- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.leftMargin.mas_equalTo(self.userNameLabel.mas_leftMargin);
            make.bottomMargin.mas_equalTo(self.avatar.mas_bottomMargin);
            make.top.mas_equalTo(self.userNameLabel.mas_bottom).mas_equalTo(5*kScale);
        }];
        [_timeLabel setFont:[UIFont systemFontOfSize:10*kScale]];
        [_timeLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _timeLabel;
}
/** 文字内容标签 */
- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [UILabel new];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setFont:[UIFont systemFontOfSize:15*kScale]];
        [_contentLabel setTextColor:kTextColor];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.mas_equalTo(self.avatar.mas_bottom).mas_equalTo(13*kScale);
            make.left.mas_equalTo(15*kScale);
            make.width.mas_equalTo((160 - 25)*kScale);
         }];
    }
    return _contentLabel;
}
/** 交互按钮底层视图 */
- (UIView *)buttonBgdView
{
    if (!_buttonBgdView)
    {
        _buttonBgdView = [UIView new];
        [self addSubview:_buttonBgdView];
        [_buttonBgdView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(45*kScale + 1);
        }];
        self.lineView.hidden = NO;
    }
    return _buttonBgdView;
}
/** 线条 */
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [self.buttonBgdView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        [_lineView setBackgroundColor:kBGDColor];
    }
    return _lineView;
}
/** 收藏按钮 */
- (PDTopicButton *)voteButton
{
    if (!_voteButton)
    {
        _voteButton = [PDTopicButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBgdView addSubview:_voteButton];
        [_voteButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.size.mas_equalTo(CGSizeMake(80*kScale, 45*kScale));
        }];
        [_voteButton normalImage:[UIImage imageNamed:@"global_icon_digg_normal_23x23_"]];
        self.centerLineView.hidden = NO;
    }
    return _voteButton;
}
/** 按钮中线 */
- (UIView *)centerLineView
{
    if (!_centerLineView)
    {
        _centerLineView = [UIView new];
        [self.buttonBgdView addSubview:_centerLineView];
        [_centerLineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.mas_equalTo(0);
             make.bottom.mas_equalTo(-15*kScale);
             make.height.mas_equalTo(20*kScale);
             make.width.mas_equalTo(1);
         }];
        [_centerLineView setBackgroundColor:kBGDColor];
    }
    return _centerLineView;
}
/** 回复按钮 */
- (PDTopicButton *)replyButton
{
    if (!_replyButton)
    {
        _replyButton = [PDTopicButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBgdView addSubview:_replyButton];
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(self.voteButton);
        }];
        [_replyButton normalImage:[UIImage imageNamed:@"global_icon_reply_23x23_"]];
    }
    return _replyButton;
}

/** 获取视图模型来设置界面数据 */
- (void)setDataWithViewModel:(PDDegImageListViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index_ = index;
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make)
    {
        make.height.mas_equalTo([_viewModel imageSizeWithIndex:_index_].height);
    }];
    [self.imageView sd_setImageWithURL:[_viewModel imageURLWithIndex:_index_]
                      placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
    [self.avatar setCircleAvatarWithURL:[_viewModel avatarURLWithImdex:_index_]
                       placeholderImage:[UIImage imageNamed:@"default_avatar_64x64_"]];
    [self.userNameLabel setText:[_viewModel userNameWithIndex:_index_]];
    [self.timeLabel setText:[_viewModel presentTimeWithIndex:_index_]];
    [self.contentLabel setText:[_viewModel contentWithIndex:_index_]];
    [self.voteButton normalTitle:[NSString stringWithFormat:@"  %@", @([_viewModel numberOfVoteWithIndex:_index_])]];
    [self.replyButton normalTitle:[NSString stringWithFormat:@"  %@", @([_viewModel numberOfReplyWithIndex:_index_])]];
}

@end

//
//  PDImgaeListCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDImageListCell.h"
#import "UIImageView+WebCache.h"

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
/** 线条 */
@property (nonatomic, strong) UIView *lineView;
/** 收藏按钮 */
@property (nonatomic, strong) UIButton *voteButton;
/** 按钮中线 */
@property (nonatomic, strong) UIView *centerLineView;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *replyButton;

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
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(50*kScreenWidth/1024, 50*kScreenWidth/1024));
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
            make.left.mas_equalTo(self.avatar.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self.avatar.mas_centerY).mas_offset(-5);;
        }];
        [_userNameLabel setFont:[UIFont systemFontOfSize:12]];
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
        }];
        [_timeLabel setFont:[UIFont systemFontOfSize:10]];
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
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(10);
             make.right.mas_equalTo(-10);
             make.top.mas_equalTo(self.avatar.mas_bottom).mas_equalTo(10);
         }];
        [_contentLabel setNumberOfLines:3];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    }
    return _contentLabel;
}
/** 线条 */
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(10);
        }];
        [_lineView setBackgroundColor:kBGDColor];
    }
    return _lineView;
}
/** 收藏按钮 */
- (UIButton *)voteButton
{
    if (!_voteButton)
    {
        _voteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_voteButton];
        [_voteButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.lineView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(79.5*kScreenWidth/1024, 45*kScreenWidth/1024));
        }];
        [_voteButton normalImage:[UIImage imageNamed:@"global_icon_digg_normal_23x23_"]];
        [_voteButton normalTitleColor:[UIColor lightGrayColor]];
    }
    return _voteButton;
}
/** 按钮中线 */
- (UIView *)centerLineView
{
    if (!_centerLineView)
    {
        _centerLineView = [UIView new];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.mas_equalTo(0);
             make.height.mas_equalTo(20);
             make.bottom.mas_equalTo(-10);
         }];
        [_lineView setBackgroundColor:kBGDColor];
    }
    return _centerLineView;
}
/** 回复按钮 */
- (UIButton *)replyButton
{
    if (!_replyButton)
    {
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_replyButton];
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(self.lineView.mas_bottom);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(self.voteButton);
        }];
        [_replyButton normalImage:[UIImage imageNamed:@"global_icon_reply_23x23_"]];
        [_replyButton normalTitleColor:[UIColor lightGrayColor]];
    }
    return _replyButton;
}

/** 获取视图模型来设置界面数据 */
- (void)setDataWithViewModel:(PDDegImageViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index_ = index;
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.mas_equalTo(0);
         make.size.mas_equalTo([_viewModel imageSizeWithIndex:_index_]);
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

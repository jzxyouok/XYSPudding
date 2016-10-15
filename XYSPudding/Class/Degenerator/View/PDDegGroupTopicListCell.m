//
//  PDDegGroupTopicCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupTopicListCell.h"

@interface PDDegGroupTopicListCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView *avatar;
/** 昵称 */
@property (nonatomic, strong) UILabel *nickNameLabel;
/** 性别标识 */
@property (nonatomic, strong) UIImageView *sexImageView;
/** 发布时间 */
@property (nonatomic, strong) UILabel *presentTimeLabel;
/** 关注按钮 */
@property (nonatomic, strong) UIButton *concernButton;
/** 文本内容 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 图片地层视图 */
@property (nonatomic, strong) UIView *imageBgdView;

/** 交互按钮底层视图 */
@property (nonatomic, strong) UIView *buttonBgdView;
/** 转发按钮 */
@property (nonatomic, strong) UIButton *repostButton;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *replyButton;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *praiseButton;

@end

@implementation PDDegGroupTopicListCell

/** 调整frame */
-(void)setFrame:(CGRect)frame
{
    CGFloat inset = 15*kScale;
    frame.size.height -= inset;
    frame.origin.y += inset;
    
    [super setFrame:frame];
}

#pragma mark - getter

/** 头像 */
- (UIImageView *)avatar
{
    if (!_avatar)
    {
        _avatar = [UIImageView new];
        [self addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(13*kScale);
            make.top.mas_equalTo(13*kScale);
            make.size.mas_equalTo(CGSizeMake(40*kScale, 40*kScale));
        }];
    }
    return _avatar;
}
/** 昵称 */
- (UILabel *)nickNameLabel
{
    if (!_nickNameLabel)
    {
        _nickNameLabel = [UILabel new];
        [_nickNameLabel setFont:[UIFont systemFontOfSize:14*kScale]];
        [_nickNameLabel setTextColor:kTextColor];
        [self addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(self.avatar.mas_right).mas_equalTo(15*kScale);
            make.top.mas_equalTo(20*kScale);
            
        }];
    }
    return _nickNameLabel;
}
/** 性别标识 */
- (UIImageView *)sexImageView
{
    if (!_sexImageView)
    {
        _sexImageView = [UIImageView new];
    }
    return _sexImageView;
}
/** 发布时间 */
- (UILabel *)presentTimeLabel
{
    if (!_presentTimeLabel)
    {
        _presentTimeLabel = [UILabel new];
        [_presentTimeLabel setFont:[UIFont systemFontOfSize:12*kScale]];
        [_presentTimeLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_presentTimeLabel];
        [_presentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.leftMargin.mas_equalTo(self.nickNameLabel.mas_leftMargin);
            make.bottomMargin.mas_equalTo(self.avatar.mas_bottomMargin);
        }];
    }
    return _presentTimeLabel;
}
/** 关注按钮 */
- (UIButton *)concernButton
{
    if (!_concernButton)
    {
        _concernButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_concernButton];
        [_concernButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(10*kScale);
            make.right.mas_equalTo(-20*kScale);
            make.size.mas_equalTo(CGSizeMake(45*kScale, 45*kScale));
        }];
        [_concernButton normalImage:[UIImage imageNamed:@"timeline_btn_follow_48x48_"]];
        [_concernButton bk_addEventHandler:^(UIButton *sender)
        {
            if (sender.tag == 0)
            {
                sender.tag = 1;
                [_concernButton normalImage:[UIImage imageNamed:@"timeline_btn_followed_48x48_"]];
            }
            else
            {
                sender.tag = 0;
                [_concernButton normalImage:[UIImage imageNamed:@"timeline_btn_follow_48x48_"]];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _concernButton;
}
/** 文本内容 */
- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [UILabel new];
        [_contentLabel setTextColor:kTextColor];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setFont:[UIFont systemFontOfSize:15*kScale]];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(13*kScale);
            make.right.mas_equalTo(-13*kScale);
            make.top.mas_equalTo(self.avatar.mas_bottom).mas_equalTo(10*kScale);
        }];
    }
    return _contentLabel;
}
/** 图片地层视图 */
- (UIView *)imageBgdView
{
    if (!_imageBgdView)
    {
        _imageBgdView = [UIView new];
        [self addSubview:_imageBgdView];
        [_imageBgdView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(self.buttonBgdView.mas_top).mas_equalTo(10*kScale);
        }];
    }
    return _imageBgdView;
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
            make.top.mas_equalTo(self.imageBgdView.mas_bottom).mas_equalTo(10*kScale);
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(40*kScale);
        }];
    }
    return _buttonBgdView;
}

/** 转发按钮 */
- (UIButton *)repostButton
{
    if (!_repostButton)
    {
        _repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBgdView addSubview:_repostButton];
        [_repostButton mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.replyButton.mas_left).mas_equalTo(0);
        }];
        [_repostButton normalImage:[UIImage imageNamed:@"timeline_icon_repost_23x23_"]];
        [_repostButton normalTitleColor:[UIColor lightGrayColor]];
        [_repostButton.titleLabel setFont:[UIFont systemFontOfSize:13*kScale]];
//        [_repostButton setImageEdgeInsets:UIEdgeInsetsMake(5, 50, 5, 50)];
//        [_repostButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _repostButton;
}
/** 回复按钮 */
- (UIButton *)replyButton
{
    if (!_replyButton)
    {
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBgdView addSubview:_replyButton];
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.bottom.mas_equalTo(0);
             make.left.mas_equalTo(self.repostButton.mas_right).mas_equalTo(0);
             make.right.mas_equalTo(self.praiseButton.mas_left).mas_equalTo(0);
             make.size.mas_equalTo(self.repostButton);
         }];
        [_replyButton normalTitleColor:[UIColor lightGrayColor]];
        [_replyButton normalImage:[UIImage imageNamed:@"timeline_icon_reply_23x23_"]];
        [_replyButton.titleLabel setFont:[UIFont systemFontOfSize:13*kScale]];
    }
    return _replyButton;
}
/** 点赞按钮 */
- (UIButton *)praiseButton
{
    if (!_praiseButton)
    {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBgdView addSubview:_praiseButton];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.top.bottom.mas_equalTo(0);
             make.left.mas_equalTo(self.replyButton.mas_right).mas_equalTo(0);
             make.size.mas_equalTo(self.repostButton);
         }];
        [_praiseButton normalImage:[UIImage imageNamed:@"timeline_icon_vote_23x23_"]];
        [_praiseButton normalTitleColor:[UIColor lightGrayColor]];
        [_praiseButton.titleLabel setFont:[UIFont systemFontOfSize:13*kScale]];
    }
    return _praiseButton;
}

#pragma mark - 数据设置

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView *view in self.backgroundView.subviews)
    {
        [view removeFromSuperview];
    }
}
/** 获取视图模型设置截面数据 */
- (void)setDataWithViewModel:(PDDegGroupTopicListViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index = index;
    
    [self.avatar setCircleAvatarWithURL:[_viewModel avatarURLWithIndex:_index]
                       placeholderImage:[UIImage imageNamed:@"default_avatar_64x64_"]];
    [self.nickNameLabel setText:[_viewModel nickNameWithIndex:_index]];
    [self.presentTimeLabel setText:[_viewModel presentTimeWithIndex:_index]];
    self.concernButton.tag = 0;
    [self.contentLabel setText:[_viewModel contentWithIndex:_index]];
    
    [self.repostButton normalTitle:[NSString stringWithFormat:@"%@", @([_viewModel repostCountWithIndex:_index])]];
    [self.replyButton normalTitle:[NSString stringWithFormat:@"%@", @([_viewModel replyCountWithIndex:_index])]];
    [self.praiseButton normalTitle:[NSString stringWithFormat:@"%@", @([_viewModel praiseCountWithIndex:_index])]];
    
    if ([_viewModel isContainImageWithIndex:_index])
    {
        NSInteger count = [_viewModel imageNumberWithIndex:_index];
        
        for (NSInteger i = 0; i < count; i++)
        {
            NSInteger row = i / 3;
            NSInteger col = i % 3;
            UIImageView *imageView = [UIImageView new];
            [self.imageBgdView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.mas_equalTo(10*kScale*col + 165*kScale*col);
                make.top.mas_equalTo(10*kScale*row + 165*kScale*row);
                make.size.mas_equalTo(CGSizeMake(165*kScale, 165*kScale));
                
                if (i == count - 1)
                {
                    make.bottom.mas_equalTo(0);
                }
            }];
            [imageView setImageWithURL:[_viewModel imageURLWithRowIndex:_index
                                                             imageIndex:i]
                      placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
        }
    }
}

@end

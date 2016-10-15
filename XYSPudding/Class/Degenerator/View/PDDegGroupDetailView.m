//
//  PDDegGroupDetailView.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupDetailView.h"


#define kGroupDetailTextColor kRGBColor(171, 163, 156)

@interface PDDegGroupDetailView ()

/** 小组图标 */
@property (nonatomic, strong) UIImageView *icon;
/** 中间细线 */
@property (nonatomic, strong) UIView *middleLine;
/** 成员数目 */
@property (nonatomic, strong) UILabel *memberCountLabel;
/** 今日话题数目 */
@property (nonatomic, strong) UILabel *todayTopicCountLabel;
/** 组长昵称 */
@property (nonatomic, strong) UILabel *creatorNameButton;
/** 小组简介 */
@property (nonatomic, strong) UILabel *introLabel;
/** 副组长昵称 */

@end

@implementation PDDegGroupDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self didCongfigBlurEffect];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        [self setClipsToBounds:YES];
    }
    return self;
}
/** 小组图标 */
- (UIImageView *)icon
{
    if (!_icon)
    {
        _icon = [UIImageView new];
        [_icon.layer setCornerRadius:10*kScale];
        [_icon setClipsToBounds:YES];
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(15*kScale);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60*kScale, 60*kScale));
        }];
    }
    return _icon;
}

/** 中间细线 */
- (UIView *)middleLine
{
    if (!_middleLine)
    {
        _middleLine = [UIView new];
        [_middleLine setBackgroundColor:kGroupDetailTextColor];
        [self addSubview:_middleLine];
        [_middleLine mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.icon.mas_bottom).mas_equalTo(10*kScale);
            make.height.mas_equalTo(13*kScale);
            make.width.mas_equalTo(1);
        }];
    }
    return _middleLine;
}

/** 成员数目 */
- (UILabel *)memberCountLabel
{
    if (!_memberCountLabel)
    {
        _memberCountLabel = [UILabel new];
        [_memberCountLabel setFont:[UIFont systemFontOfSize:13*kScale]];
        [_memberCountLabel setTextColor:kGroupDetailTextColor];
        [self addSubview:_memberCountLabel];
        [_memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.topMargin.mas_equalTo(self.middleLine.mas_topMargin);
            make.right.mas_equalTo(self.middleLine.mas_left).mas_equalTo(-10*kScale);
        }];
    }
    return _memberCountLabel;
}
/** 今日话题数目 */
- (UILabel *)todayTopicCountLabel
{
    if (!_todayTopicCountLabel)
    {
        _todayTopicCountLabel = [UILabel new];
        [_todayTopicCountLabel setFont:[UIFont systemFontOfSize:13*kScale]];
        [_todayTopicCountLabel setTextColor:kGroupDetailTextColor];
        [self addSubview:_todayTopicCountLabel];
        [_todayTopicCountLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.topMargin.mas_equalTo(self.middleLine.mas_topMargin);
            make.left.mas_equalTo(self.middleLine.mas_right).mas_equalTo(10*kScale);
        }];
    }
    return _todayTopicCountLabel;
}

/** 接收小组详情视图模型 */
- (void)setGroupDetailVM:(PDDegGroupDetailViewModel *)groupDetailVM
{
    _groupDetailVM = groupDetailVM;
    
    [self.icon setImageWithURL:[_groupDetailVM iconURL]
              placeholderImage:[UIImage imageNamed:@"default_avatar_64x64_"]];
    [self.memberCountLabel setText:[NSString stringWithFormat:@"成员：%@", @([_groupDetailVM numberOfMembers])]];
    [self.todayTopicCountLabel setText:[NSString stringWithFormat:@"今日主题：%@", @([_groupDetailVM numberOfTodatTopics])]];
}

/** 设置模糊效果 */
- (void)didCongfigBlurEffect
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(0);
     }];
}

@end

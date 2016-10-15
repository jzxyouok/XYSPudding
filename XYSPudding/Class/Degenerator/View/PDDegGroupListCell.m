//
//  PDDegGroupsCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupListCell.h"

@interface PDDegGroupListCell ()

/** 小组图标视图 */
@property (nonatomic, strong) UIImageView *iconView;
/** 小组标题标签 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 小组成员数目标签 */
@property (nonatomic, strong) UILabel *memberCountLabel;
/** 今日主题数目标签 */
@property (nonatomic, strong) UILabel *todayTopicCountLabel;

@end

@implementation PDDegGroupListCell

#pragma mark - getter

/** 小组图标视图 */
- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [UIImageView new];
        [_iconView.layer setCornerRadius:5*kScale];
        [_iconView setContentMode:UIViewContentModeScaleAspectFill];
        [_iconView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60*kScale);
            make.height.mas_equalTo(60*kScale);
        }];
        [_iconView setClipsToBounds:YES];
    }
    return _iconView;
}
/** 小组标题标签 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont systemFontOfSize:18*kScale]];
        [_titleLabel setTextColor:kTextColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(-14*kScale);
        }];
    }
    return _titleLabel;
}
/** 小组成员数目标签 */
- (UILabel *)memberCountLabel
{
    if (!_memberCountLabel)
    {
        _memberCountLabel = [UILabel new];
        [self addSubview:_memberCountLabel];
        [_memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.leftMargin.mas_equalTo(self.titleLabel.mas_leftMargin);
            make.centerY.mas_equalTo(12*kScale);
            make.width.mas_equalTo(70*kScale);
        }];
        [_memberCountLabel setFont:[UIFont systemFontOfSize:14*kScale]];
        [_memberCountLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _memberCountLabel;
}
/** 今日主题数目标签 */
- (UILabel *)todayTopicCountLabel
{
    if (!_todayTopicCountLabel)
    {
        _todayTopicCountLabel = [UILabel new];
        [self addSubview:_todayTopicCountLabel];
        [_todayTopicCountLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(self.memberCountLabel.mas_right).mas_equalTo(20*kScale);
             make.bottomMargin.mas_equalTo(self.memberCountLabel.mas_bottomMargin);
         }];
        [_todayTopicCountLabel setFont:[UIFont systemFontOfSize:14*kScale]];
        [_todayTopicCountLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _todayTopicCountLabel;
}

/** 通过接收到的视图模型，设置界面数据 */
- (void)setDataWithViewModel:(PDDegGroupViewModel *)groupViewModel
                       index:(NSInteger)index
{
    _groupViewModel = groupViewModel;
    _index = index;
    
    [self.iconView setImageWithURL:[_groupViewModel imageURLWithIndex:_index] placeholderImage:nil];
    [self.titleLabel setText:[_groupViewModel nameWithIndex:_index]];
    [self.memberCountLabel setText:[_groupViewModel memberCountWithIndex:_index]];
    [self.todayTopicCountLabel setText:[_groupViewModel todayTopicCountWithIndex:_index]];
}
@end

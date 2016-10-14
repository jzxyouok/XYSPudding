//
//  PDDegGroupsCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupsCell.h"

@interface PDDegGroupsCell ()

/** 小组图标视图 */
@property (nonatomic, strong) UIImageView *iconView;
/** 小组标题标签 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 小组成员数目标签 */
@property (nonatomic, strong) UILabel *memberCountLabel;
/** 今日主题数目标签 */
@property (nonatomic, strong) UILabel *todayTopicCountLabel;

@end

@implementation PDDegGroupsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    return self;
}

#pragma mark - getter

/** 小组图标视图 */
- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [UIImageView new];
        [_iconView.layer setCornerRadius:5];
        [_iconView setContentMode:UIViewContentModeScaleAspectFill];
        [_iconView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(self.mas_height).mas_equalTo(-20);
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
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(18);
        }];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        
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
            make.bottom.mas_equalTo(-18);
            make.width.mas_equalTo(80);
        }];
        [_memberCountLabel setFont:[UIFont systemFontOfSize:12]];
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
             make.left.mas_equalTo(self.memberCountLabel.mas_right).mas_equalTo(20);
             make.bottomMargin.mas_equalTo(self.memberCountLabel.mas_bottomMargin);
         }];
        [_todayTopicCountLabel setFont:[UIFont systemFontOfSize:12]];
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

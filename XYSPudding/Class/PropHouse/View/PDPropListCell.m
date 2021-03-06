//
//  PDPropListCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPropListCell.h"

@interface PDPropListCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 文字标签（new\hot\无） */
@property (nonatomic, strong) UILabel *label;
/** 标题信息 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 价格 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 浏览人数 */
@property (nonatomic, strong) UILabel *visitorsLabel;

@end

@implementation PDPropListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:5*kScaleW];
        [self setClipsToBounds:YES];
    }
    return self;
}

/** 图片 */
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
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_width);
        }];
    }
    return _imageView;
}

/** 图片标签（new\hot\无） */
- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel new];
        [_label setTextColor:[UIColor whiteColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:15*kScaleW]];
        [_label setClipsToBounds:YES];
        [_label.layer setCornerRadius:5*kScaleW];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(15*kScaleW);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(15*kScaleW);
        }];
    }
    return _label;
}

/** 标题信息 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont systemFontOfSize:16*kScaleW]];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setTextColor:kTextColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(14*kScaleW);
            make.left.mas_equalTo(14*kScaleW);
            make.right.mas_equalTo(-14*kScaleW);
        }];
    }
    return _titleLabel;
}
/** 价格 */
- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel = [UILabel new];
        [_priceLabel setFont:[UIFont systemFontOfSize:13*kScaleW]];
        [_priceLabel setTextColor:kNaviTextColor];
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(14*kScaleW);
            make.bottom.mas_equalTo(-14*kScaleW);
        }];
    }
    return _priceLabel;
}

/** 浏览人数 */
- (UILabel *)visitorsLabel
{
    if (!_visitorsLabel)
    {
        _visitorsLabel = [UILabel new];
        [_visitorsLabel setFont:[UIFont systemFontOfSize:13*kScaleW]];
        [_visitorsLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_visitorsLabel];
        [_visitorsLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.bottom.mas_equalTo(-14*kScaleW);
        }];
    }
    return _visitorsLabel;
}

#pragma mark - 数据设置

- (void)setDataWithViewModel:(PDPropGoodsListViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index = index;
    
    [self.imageView setImageWithURL:[_viewModel imageURLWithIndex:_index]
                   placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
    NSString *labelStr = [_viewModel labelWithIndex:_index];
    if (labelStr)
    {
        if ([labelStr isEqualToString:@"NEW"])
        {
            [self.label setBackgroundColor:[UIColor greenColor]];
        }
        else if ([labelStr isEqualToString:@"HOT"])
        {
            [self.label setBackgroundColor:[UIColor redColor]];
        }
    }
    [self.label setText:labelStr];
    [self.titleLabel setText:[_viewModel titleWithIndex:_index]];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%.2lf", [_viewModel priceWithIndex:_index]]];
    [self.visitorsLabel setText:[NSString stringWithFormat:@"%@ 人看过", @([_viewModel numberOfVisitorsWithIndex:_index])]];
}


@end

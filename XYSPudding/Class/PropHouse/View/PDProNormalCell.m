//
//  PDProNormalCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDProNormalCell.h"

@interface PDProNormalCell ()

/** 图标视图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 描述性标签 */
@property (nonatomic, strong) UILabel *describeLabel;
/** 图片指示器 */
@property (nonatomic, strong) UIImageView *indImageView;

@end

@implementation PDProNormalCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.indImageView.hidden = NO;
        [self setTitle:@"我的优惠券"];
        [self setImageName:@"shop_icon_coupon_28x28_"];
    }
    return self;
}


#pragma mark - getter

/** 图标视图 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(10);
             make.centerY.mas_equalTo(0);
             make.width.mas_equalTo(28*kScale);
             make.height.mas_equalTo(28*kScale);
         }];
    }
    return _imageView;
}
/** 标题 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(self.imageView.mas_right).mas_equalTo(10*kScale);
             make.centerY.mas_equalTo(0);
         }];
        [_titleLabel setTextColor:kTextColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:18*kScale]];
    }
    return _titleLabel;
}
/** 描述性标签 */
- (UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [UILabel new];
        [_describeLabel setTextColor:[UIColor lightGrayColor]];
        [_describeLabel setFont:[UIFont systemFontOfSize:17*kScale]];
        [self.contentView addSubview:_describeLabel];
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.mas_equalTo(self.indImageView.mas_left).mas_equalTo(0);
             make.centerY.mas_equalTo(0);
         }];
    }
    return _describeLabel;
}
/** 图片指示器 */
- (UIImageView *)indImageView
{
    if (!_indImageView)
    {
        _indImageView = [UIImageView new];
        [_indImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_indImageView];
        [_indImageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerY.mas_equalTo(0);
             make.right.mas_equalTo(0);
             make.width.mas_equalTo(28*kScale);
             make.height.mas_equalTo(28*kScale);
         }];
        [_indImageView setImage:[UIImage imageNamed:@"home_anime_indicator_28x28_"]];
    }
    return _indImageView;
}

#pragma mark - setter

/** 设置图片 */
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self.imageView setImage:[UIImage imageNamed:_imageName]];
}

/** 设置标题 */
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:_title];
}

/** 描述信息 */
- (void)setDescribe:(NSString *)describe
{
    _describe = describe;
    [self.describeLabel setText:_describe];
}

@end

//
//  PDDegNormalCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegNormalCell.h"

@interface PDDegNormalCell ()

/** 图标视图 */
@property (nonatomic, strong) UIImageView *imageView_;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 描述性标签 */
@property (nonatomic, strong) UILabel *describeLabel;
/** 图片指示器 */
@property (nonatomic, strong) UIImageView *indImageView;

@end

@implementation PDDegNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        self.indImageView.hidden = NO;
    }
    return self;
}

#pragma mark - getter

/** 图标视图 */
- (UIImageView *)imageView_
{
    if (!_imageView_)
    {
        _imageView_ = [UIImageView new];
        [self.contentView addSubview:_imageView_];
        [_imageView_ mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(10);
             make.centerY.mas_equalTo(0);
         }];
    }
    return _imageView_;
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
             make.left.mas_equalTo(self.imageView_.mas_right).mas_equalTo(10);
             make.centerY.mas_equalTo(0);
         }];
        [_titleLabel setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
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
        [_describeLabel setFont:[UIFont systemFontOfSize:15]];
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
        [self addSubview:_indImageView];
        [_indImageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [_indImageView setImage:[UIImage imageNamed:@"home_anime_indicator_28x28_"]];
    }
    return _indImageView;
}

#pragma mark - setter

/** 设置图片 */
- (void)setImageName_:(NSString *)imageName_
{
    _imageName_ = imageName_;
    [self.imageView_ setImage:[UIImage imageNamed:_imageName_]];
}

/** 设置标题 */
- (void)setTitle_:(NSString *)title_
{
    _title_ = title_;
    [self.titleLabel setText:_title_];
}

/** 描述信息 */
- (void)setDescribe:(NSString *)describe
{
    _describe = describe;
    [self.describeLabel setText:_describe];
}
@end

//
//  PDDegNormalCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegNormalCell.h"

@interface PDDegNormalCell ()

@property (nonatomic, strong) UIImageView *imageView_;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PDDegNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.imageView_];
        [_imageView_ mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(10);
             make.centerY.mas_equalTo(0);
         }];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(self.imageView_.mas_right).mas_equalTo(10);
             make.centerY.mas_equalTo(0);
         }];
    }
    return self;
}

#pragma mark - setter && getter

- (UIImageView *)imageView_
{
    if (!_imageView_)
    {
        _imageView_ = [UIImageView new];
    }
    return _imageView_;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (void)setTitle_:(NSString *)title_
{
    _title_ = title_;
    [_titleLabel setText:_title_];
}

- (void)setImageName_:(NSString *)imageName_
{
    _imageName_ = imageName_;
    [_imageView_ setImage:[UIImage imageNamed:_imageName_]];
}
@end

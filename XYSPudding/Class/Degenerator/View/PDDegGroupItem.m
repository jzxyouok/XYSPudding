//
//  PDDegGroupItem.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupItem.h"

@interface PDDegGroupItem ()

/** 图片视图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 标题标签 */
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *button;
@end

@implementation PDDegGroupItem

#pragma mark - getter

/** 图片视图 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [_imageView.layer setCornerRadius:5];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-11*kScale);
            make.width.mas_equalTo(100*kScale);
            make.height.mas_equalTo(100*kScale);
        }];
    }
    return _imageView;
}
/** 标题标签 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [_titleLabel setTextColor:[UIColor lightGrayColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:12*kScale]];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(10);
        }];
    }
    return _titleLabel;
}

/** 按钮 */
- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_button];
    
        [_button mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.edges.mas_equalTo(0);
        }];
        [_button bk_addEventHandler:^(id sender)
        {
            if (_clickHandler)
            {
                _clickHandler(self.tag);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - setter

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self.button setHidden:NO];
    self.userInteractionEnabled = YES;
    [self.imageView setImageWithURL:_imageURL
                   placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;

    [self.titleLabel setText:_title];
}

- (void)clickHandler:(ClickHandler)clickHandler
{
    _clickHandler = clickHandler;
}

@end

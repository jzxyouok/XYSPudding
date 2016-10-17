//
//  PDHPGroupCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHPGroupCell.h"
#import "PDHPGroupView.h"

@interface PDHPGroupCell ()

/** 分组标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PDHPGroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self addGroupView];
    }
    return self;
}
/** 分组标题 */
- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
        }];
    }
    return _titleLabel;
}

- (void)addGroupView
{
    for (NSInteger i = 0; i < 4; i++)
    {
        NSInteger row = i / 2;
        NSInteger col = i % 2;
        PDHPGroupView *groupView = [PDHPGroupView new];
        [groupView setBackgroundColor:[UIColor whiteColor]];
        [groupView setTag:i+100];
        [self addSubview:groupView];
        [groupView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(13*kScale*(col+1) + 240*kScale*col);
             make.top.mas_equalTo(13*kScale*(row+1) + 210*kScale*row);
             make.size.mas_equalTo(CGSizeMake(240*kScale, 210*kScale));
         }];
    }
}

- (void)setDataWithViewModel:(PDHPGroupViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index = index;

    [self.titleLabel setText:[self groupNames][_index]];
    
    for (NSInteger i = 0; i < _viewModel.animeNumber; i++)
    {
        PDHPGroupView *groupView = [self viewWithTag:i+100];
        [groupView.imageView setImageWithURL:[_viewModel imageURLWithIndex:i]
                                  placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
        [groupView.nameLabel setText:[_viewModel animeNameWithIndex:i]];
    }
}

- (NSArray *)groupNames
{
    return @[@"番组推荐", @"最近更新", @"国产动画", @"完结推荐"];
}

@end

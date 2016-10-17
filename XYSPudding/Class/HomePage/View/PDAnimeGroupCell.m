//
//  PDAnimeGroupCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDAnimeGroupCell.h"
#import "PDAnimeShowView.h"
#import "PDAnimeGroupHeadView.h"

@interface PDAnimeGroupCell ()

/** 分组头部视图 */
@property (nonatomic, strong) PDAnimeGroupHeadView *groupHeadView;
/** 底线 */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation PDAnimeGroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self addShowView];
        [self.bottomLineView setHidden:NO];
    }
    return self;
}

/** 分组头部视图 */
- (PDAnimeGroupHeadView *)groupHeadView
{
    if (!_groupHeadView)
    {
        _groupHeadView = [PDAnimeGroupHeadView new];
        [self addSubview:_groupHeadView];
        [_groupHeadView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(55*kScaleW);
        }];
    }
    return _groupHeadView;
}
/** 动画展示视图 */
- (void)addShowView
{
    for (NSInteger i = 0; i < 4; i++)
    {
        PDAnimeShowView *showView = [PDAnimeShowView new];
        [showView setTag:i+100];
        [self addSubview:showView];
        [showView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(0 + i*120*kScaleW + i*5*kScaleW);
             make.bottom.mas_equalTo(0);
             make.width.mas_equalTo(119*kScaleW);
             make.height.mas_equalTo(190*kScaleW);
         }];
        [showView.imageView setImageWithURL:[_viewModel displayImageURLWithIndex:_index AnimeIndex:i]
                           placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
    }
}

/** 底线 */
- (UIView *)bottomLineView
{
    if(!_bottomLineView)
    {
        _bottomLineView = [UIView new];
        [_bottomLineView setBackgroundColor:kRGBColor(231, 234, 236)];
        [self addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return _bottomLineView;
}

/** 设置界面数据 */
- (void)setDataWithViewModel:(PDAnimeGroupListViewModel *)viewModel
                       index:(NSInteger)index
{
    _viewModel = viewModel;
    _index = index;
    
    [self.groupHeadView.titleLabel setText:[_viewModel titleWithIndex:_index]];
    [self.groupHeadView.countOfSpeciesLabel setText:[NSString stringWithFormat:@"%@", @([_viewModel numberOfAnimesSpeciesWithIndex:_index])]];
    
    for (NSInteger i = 0; i < 4; i++)
    {
        PDAnimeShowView *showView = (PDAnimeShowView *)[self viewWithTag:i+100];
        [showView.imageView setImageWithURL:[_viewModel displayImageURLWithIndex:_index AnimeIndex:i]
                           placeholderImage:[UIImage imageNamed:@"global_thumb_60x60_"]];
        [showView.nameLabel setText:[_viewModel animeNameWithIndex:_index
                                                        AnimeIndex:i]];
        [showView.numberLabel setText:[NSString stringWithFormat:@"%@", @([_viewModel numberOfDisplayAnimesWithIndex:_index AnimeIndex:i])]];
    }
}

@end

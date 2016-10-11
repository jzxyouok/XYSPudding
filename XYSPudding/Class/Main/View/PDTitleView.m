//
//  PDTitleView.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTitleView.h"

@interface PDTitleView ()

@end

@implementation PDTitleView

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init])
    {
        _titles = [titles copy];
    }
    return self;
}

/** 添加标题标签 */
- (void)addItems
{
    NSInteger count = _titles.count;
    for (NSString *title in _titles)
    {
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo((self.width-1)/count);
        }];
        
        if (![title isEqualToString:_titles[count-1]])
        {
            UIImageView *lineView = [UIImageView new];
            [lineView setImage:[UIImage imageNamed:@"bar"]];
            
        }
    }
}

@end

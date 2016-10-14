//
//  PDPrivateHomeCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPrivateHomeCell.h"
#import "PDPrivateHomeButton.h"
#import "PDLoginViewController.h"

@implementation PDPrivateHomeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self setBackgroundColor:kBGDColor];
        [self setSelected:NO];
    }
    return self;
}

- (void)setCellDatas:(NSArray *)cellDatas
        clickHandler:(void(^)(NSInteger index))clickHandler
{
    _cellDatas = [cellDatas copy];
    
    NSInteger count = _cellDatas.count;
    for (NSInteger i=0; i<count; i++)
    {
        PDPrivateHomeButton *button = [PDPrivateHomeButton new];
        [button setTag:i+100];
        [button setValuesForKeysWithDictionary:_cellDatas[i]];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(kScreenWidth/3.0*i);
             make.top.bottom.mas_equalTo(0);
             make.width.mas_equalTo(kScreenWidth/3.0);
         }];
        [button clickHandler:^(NSInteger tag)
        {
            clickHandler(tag-100);
        }];
    }
}

@end

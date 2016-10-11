//
//  PDPrivateHomeCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPrivateHomeCell.h"
#import "PDPrivateHomeButton.h"

@implementation PDPrivateHomeCell

- (void)setCellDatas:(NSArray *)cellDatas
{
    _cellDatas = [cellDatas copy];
    
    NSInteger count = _cellDatas.count;
    for (NSInteger i=0; i<count; i++)
    {
        PDPrivateHomeButton *button = [PDPrivateHomeButton buttonWithType:UIButtonTypeSystem];
        [button setValuesForKeysWithDictionary:_cellDatas[i]];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(kScreenWidth/3.0*i);
             make.top.bottom.mas_equalTo(0);
             make.width.mas_equalTo(kScreenWidth/3.0);
         }];
    }
}

@end

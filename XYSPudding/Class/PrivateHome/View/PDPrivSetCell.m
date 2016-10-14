//
//  PDPrivSetCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/13.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPrivSetCell.h"

@implementation PDPrivSetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
//        [self addSwitch];
    }
    return self;
}

/** 添加开关按钮 */
- (void)addSwitch
{
    UISwitch *switch_ = [UISwitch new];
    [self.contentView addSubview:switch_];
    [switch_ mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(10);
    }];
}
@end

//
//  PDDegGroupCell.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupCell.h"
#import "UIButton+WebCache.h"
#import "PDDegGroupItem.h"

@implementation PDDegGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style
                     reuseIdentifier:reuseIdentifier])
    {
        [self addGroups];
    }
    return self;
}
/** 添加分组视图 */
- (void)addGroups
{
    UIButton *lastView = nil;
    for (int i = 0; i<8; i++)
    {
        PDDegGroupItem *button = [PDDegGroupItem buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [self.contentView addSubview:button];
        
        if (!lastView)
        {
            [button mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(130*kScreenWidth/1024.0, 130*kScreenWidth/1024.0));
            }];
        }
        else
        {
            [button mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.mas_equalTo(lastView.mas_right).mas_equalTo(0);
                 make.top.mas_equalTo(0);
                 make.size.mas_equalTo(lastView);
             }];
        }
        lastView = button;
    }
}

- (void)setGroupViewModel:(PDDegGroupViewModel *)groupViewModel
{
    _groupViewModel = groupViewModel;
    
    NSInteger count = [_groupViewModel groupNumber];
    for (NSInteger i = 0; i < count; i++)
    {
        PDDegGroupItem *button = [self.contentView viewWithTag:100+i];
        [button sd_setImageWithURL:[_groupViewModel imageURLWithIndex:i]
                          forState:UIControlStateNormal];
        [button normalTitle:[_groupViewModel nameWithIndex:i]];
    }
}
@end

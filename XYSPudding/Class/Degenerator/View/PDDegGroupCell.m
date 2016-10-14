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
#import "PDDegGroupTopicListController.h"

@implementation PDDegGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style
                     reuseIdentifier:reuseIdentifier])
    {
        self.selected = NO;
        [self addGroups];
    }
    return self;
}
/** 添加分组视图 */
- (void)addGroups
{
    PDDegGroupItem *lastView = nil;
    for (int i = 0; i<8; i++)
    {
        PDDegGroupItem *button = [PDDegGroupItem new];
        button.tag = 100+i;
        [self.contentView addSubview:button];
        
        if (!lastView)
        {
            [button mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(148*kScale, 148*kScale));
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

- (void)setDataWithViewModel:(PDDegGroupViewModel *)groupViewModel
                clickHandler:(void(^)(NSInteger))handler
{
    _groupViewModel = groupViewModel;
    
    NSInteger count = [_groupViewModel groupNumber];
    for (NSInteger i = 0; i < count; i++)
    {
        PDDegGroupItem *button = [self.contentView viewWithTag:100+i];
//        [button sd_setImageWithURL:[_groupViewModel imageURLWithIndex:i]
//                          forState:UIControlStateNormal];
//        [button normalTitle:[_groupViewModel nameWithIndex:i]];
//        [button bk_addEventHandler:^(UIButton *sender)
//        {
//            handler(sender.tag-100);
//        } forControlEvents:UIControlEventTouchUpInside];
        
        [button setImageURL:[_groupViewModel imageURLWithIndex:i]];
        [button setTitle:[_groupViewModel nameWithIndex:i]];
    }
}
@end

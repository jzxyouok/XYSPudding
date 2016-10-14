//
//  UIViewController+NavigationItem.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

/** 标签竖向偏移值 */
#define itemOffsetY 44*(1-kScale)*0.5

@implementation UIViewController (NavigationItem)

/** 添加左侧标签 */
- (void)addLeftItemWithStyle:(PDLeftItemStyle)style
                clickHandler:(void(^)())clickHandler
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImageEdgeInsets:UIEdgeInsetsMake(itemOffsetY, 0, 0-itemOffsetY, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(itemOffsetY, 0, 0-itemOffsetY, 0)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16*kScale]];
    [button normalTitleColor:[UIColor orangeColor]];

    switch (style)
    {
        case PDLeftItemStyleBackImage:
        {
            [button normalImage:[UIImage imageNamed:@"global_header_btn_back_normal_44x44_"]];
            [button setSize:CGSizeMake(44*kScale, 44*kScale)];
            break;
        }
    }
    [button bk_addEventHandler:^(id sender)
     {
         clickHandler();
     } forControlEvents:UIControlEventTouchUpInside];
    /*  使用弹簧控件缩小菜单按钮和边缘距离 */
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -20;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
}
/** 添加右侧标签 */
- (void)addRightItemWithStyle:(PDRightItemStyle)style
            clickHandler:(void(^)())clickHandler
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(itemOffsetY, 0, 0-itemOffsetY, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(itemOffsetY, 0, 0-itemOffsetY, 0)];
    [button normalTitleColor:[UIColor orangeColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16*kScale]];
    switch (style)
    {
        case PDRightItemStyleTitle1:
        {
            [button normalTitle:@"用户协议"];
            [button sizeToFit];
            break;
        }
        case PDRightItemStyleSearchImage:
        {
            [button normalImage:[UIImage imageNamed:@"global_header_btn_search_normal_44x44_"]];
            [button setSize:CGSizeMake(44*kScale, 44*kScale)];
            break;
        }
    }
    [button bk_addEventHandler:^(id sender)
     {
         clickHandler();
     } forControlEvents:UIControlEventTouchUpInside];
    /*  使用弹簧控件缩小菜单按钮和边缘距离 */
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -10;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[spaceItem, rightItem];
}

/** 带动态图片的上拉刷新页面 */
- (MJRefreshGifHeader *)gifHeaderWithRefreshingBlock:(void(^)())block
{
    MJRefreshGifHeader * gifRefreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^
                                             {
                                                 block();
                                             }];
    [gifRefreshHeader setImages:@[[UIImage imageNamed:@"pudding_anime_1_50x50_"]]
                       forState:MJRefreshStateIdle];
    [gifRefreshHeader setImages:@[[UIImage imageNamed:@"pudding_anime_1_50x50_"],
                                  [UIImage imageNamed:@"pudding_anime_2_50x50_"]]
                       duration:0.5
                       forState:MJRefreshStateRefreshing];
    gifRefreshHeader.stateLabel.hidden = YES;
    gifRefreshHeader.labelLeftInset = -90;
    [gifRefreshHeader beginRefreshing];
    
    return gifRefreshHeader;
}

@end

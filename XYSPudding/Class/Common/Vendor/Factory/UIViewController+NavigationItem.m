//
//  UIViewController+NavigationItem.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

@implementation UIViewController (NavigationItem)

/** 添加左侧标签 */
- (void)addLeftItemWithStyle:(PDLeftItemStyle)style
                clickHandler:(void(^)())clickHandler
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    switch (style)
    {
        case PDLeftItemStyleBackImage:
        {
            [button normalImage:[UIImage imageNamed:@"global_header_btn_back_normal_44x44_"]];
            break;
        }
    }
    [button sizeToFit];
    [button setImageEdgeInsets:UIEdgeInsetsMake(7, 0, -7, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(7, 0, -7, 0)];
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
    [button normalTitleColor:[UIColor orangeColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    switch (style)
    {
        case PDRightItemStyleTitle1:
        {
            [button normalTitle:@"用户协议"];
            break;
        }
        case PDRightItemStyleSearchImage:
        {
            [button normalImage:[UIImage imageNamed:@"global_header_btn_search_normal_44x44_"]];
            break;
        }
    }
    [button sizeToFit];
    [button setImageEdgeInsets:UIEdgeInsetsMake(7, 0, -7, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(7, 0, -7, 0)];

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

@end

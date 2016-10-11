//
//  UINavigationController+Item.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "UINavigationController+Item.h"

@implementation UINavigationController (Item)

/** 添加左侧标签 */
- (void)addLeftItemWith:(PDLeftItemStyle)style
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
    
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button bk_addEventHandler:^(id sender)
    {
        clickHandler();
    } forControlEvents:UIControlEventTouchUpInside];
    /*  使用弹簧控件缩小菜单按钮和边缘距离 */
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width = -10;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
}
/** 添加右侧标签 */
- (void)addRightItemWith:(PDLeftItemStyle)style
            clickHandler:(void(^)())clickHandler
{
    
}

@end

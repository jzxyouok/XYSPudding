//
//  UIViewController+NavigationItem.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 导航栏左侧标签类型 */
typedef NS_ENUM(NSInteger, PDLeftItemStyle)
{
    PDLeftItemStyleBackImage
};
/** 导航栏右侧标签类型 */
typedef NS_ENUM(NSInteger, PDRightItemStyle)
{
    PDRightItemStyleTitle1
};

@interface UIViewController (NavigationItem)

/** 添加左侧标签 */
- (void)addLeftItemWithStyle:(PDLeftItemStyle)style
                clickHandler:(void(^)())clickHandler;
/** 添加右侧标签 */
- (void)addRightItemWithStyle:(PDRightItemStyle)style
                 clickHandler:(void(^)())clickHandler;

@end

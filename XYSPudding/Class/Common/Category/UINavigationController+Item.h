//
//  UINavigationController+Item.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PDLeftItemStyle)
{
    PDLeftItemStyleBackImage
};

@interface UINavigationController (Item)

/** 添加左侧标签 */
- (void)addLeftItemWith:(PDLeftItemStyle)style
           clickHandler:(void(^)())clickHandler;
/** 添加右侧标签 */
- (void)addRightItemWith:(PDLeftItemStyle)style
            clickHandler:(void(^)())clickHandler;

@end

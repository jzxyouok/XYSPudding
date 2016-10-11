//
//  UIView+Frame.m
//  XYSBaiSiBuDeQiJie
//
//  Created by 徐玉珊 on 16/8/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - 设置视图的frame参数（宽高、坐标）

/* 定义frme宽度的大小 */
- (CGFloat)width
{
    return self.frame.size.width;//返回frame的宽度
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame; //读取frame
    frame.size.width = width; //修改读取的frame的宽
    self.frame = frame; //写回frame
}

/* 定义frme高度的大小 */
- (CGFloat)height
{
    return self.frame.size.height; //返回frame的高度
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height= height;
    self.frame = frame;
}

/* 定义frme坐标点x的位置 */
- (CGFloat)x
{
    return self.frame.origin.x; //返回frame的x点位置
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame; //读取frame
    frame.origin.x = x; //修改读取的frame的x
    self.frame = frame; //写回frame
}

/* 定义frme坐标点y的大小 */
- (CGFloat)y
{
    return self.frame.origin.y; //返回frame的y点位置
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/* 定义frme的大小 */
- (CGSize)size
{
    return self.frame.size; //返回frame的大小
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/* 定义frme原点位置 */
- (CGPoint)origin
{
    return self.frame.origin; //返回frame的左上点坐标（原点）
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


/**
 *  视图的frme中心点参数设置
 *
 */

/* 定义frme在父视图的位置 */
- (CGPoint)position
{
    return self.center;
}

- (void)setPosition:(CGPoint)position
{
    CGPoint center = self.center;
    center = position;
    self.center = center;
}

/* 定义frme中心点x的大小 */
- (CGFloat)positionX
{
    return self.center.x;
}

- (void)setPositionX:(CGFloat)positionX
{
    CGPoint center = self.center;
    center.x = positionX;
    self.center = center;
}

/* 定义frme中心点y的大小 */
- (CGFloat)positionY
{
    return self.center.y;
}

- (void)setPositionY:(CGFloat)positionY
{
    CGPoint center = self.center;
    center.y = positionY;
    self.center = center;
}



/**
 *  视图的bounds中心点参数设置
 *
 */

/* 获取bounds的中心点 */
- (CGPoint)selfCenter
{
    return CGPointMake(self.width*0.5f, self.height*0.5f);
}

- (void)setSelfCenter:(CGPoint)selfCenter
{
    
}

/* 定义bounds中心点x的大小 */
- (CGFloat)selfCenterX
{
    return self.selfCenter.x;
}

- (void)setSelfCenterX:(CGFloat)selfCenterX
{
    
}

/* 定义bounds中心点y的大小 */
- (CGFloat)selfCenterY
{
    return self.selfCenter.y;
}

- (void)setSelfCenterY:(CGFloat)selfCenterY
{

}

+ (id)viewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}


@end
